#!/usr/bin/env python
'''
hyperpyg.py

A command line tool to syntax highlight code blocks in HTML files.

## Typical usage:

Given a file `example.html`:

    <html><body>
        <pre syntax="python">
            for i in range(10):
                print "Hello, world!"
        </pre>
    </body></html>

The `<pre>` tag must include a "syntax=LANG" attribute for the script to pick up the
tag for processing.

Run hyperpyg thus:

    $ hyperpyg.py example.html -o example2.html

Shell invocation to process all the html files in `$HOME/htdocs`.

    $find ~/htdocs | grep html$ | xargs grep -l "<pre syntax=" | xargs -I {} -t ./hyperpyg.py -f {} -o {} -q


## Options

Refer to pygments documentation for list of available options on lexers and  styles.

    
'''
try:
    from pygments import highlight
    from pygments.lexers import get_lexer_by_name
    from pygments.formatters import HtmlFormatter
    from pygments.styles import get_style_by_name
except ImportError, e:
    print 'requires python pygments library'
    exit(1)
try:
    from BeautifulSoup import BeautifulSoup
except ImportError, e:
    print 'requires beautifulsoup library'
    print e
    exit(1)
import codecs
from optparse import OptionParser
import logging

logging.basicConfig(level=logging.ERROR)
logger = logging.getLogger('hyperpyg')

def main():
    parser = OptionParser()
    parser.add_option("-f", "--infile", dest="infile",
                      help="process INFILE", metavar="FILE")
    parser.add_option("-o", "--outfile", dest="outfile",
                      help="write to OUTFILE", metavar="FILE")
    
    parser.add_option("-q", "--quiet",
                      action="store_false", dest="quiet", default=True,
                      help="don't print status messages to stdout")
    parser.add_option("-l", "--linenos",
                      action="store_false", dest="linenos", default=False,
                      help="don't print status messages to stdout")
    
    parser.add_option("-s", "--style",
                      action="store", type="string", dest="style",
                      default='colorful')
    parser.add_option("-c", "--cssclass",
                      action="store", type="string", dest="cssclass",
                      default='highlight')
    
    
    (options, args) = parser.parse_args()
    if not (options.infile and options.outfile):
        parser.print_help()
        exit(1)
        
    if not options.quiet:
        logger.setLevel(logging.DEBUG)
        
    with codecs.open(options.infile, mode='r', encoding='utf8') as inp:
        logger.debug("INFILE: %s" % (options.infile, ))
        soup = BeautifulSoup(inp.read())
        pres = soup.findAll('pre')
        changed = False
        for pre in pres:
            lang = pre.get('syntax',None)
            logger.debug("lexer : %s " % (lang, ))
            if lang:
                lexer = get_lexer_by_name(lang)
                logger.debug("lexer: %s" % (lexer, ))
                style = get_style_by_name(options.style)
                logger.debug("style : %s" % (style, ))
                formatter = HtmlFormatter(linenos=options.linenos,
                                          cssclass=options.cssclass,
                                          style=style)
                result = highlight(pre.contents[0], lexer, formatter)
                pre.replaceWith(result)
                changed = True
        if changed:
            with codecs.open(options.outfile, mode='w', encoding='utf8') as outp:
                logger.debug("OUTFILE: %s" % (options.outfile, ))
                outp.write(str(soup))
        
        
if __name__ == '__main__':
    main()


