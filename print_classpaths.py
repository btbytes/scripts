#!/usr/bin/env python
"""print_classpaths.py

print classpaths for use with Java build system/compiler.

    $ ./print_classpaths.py ["/path/to/*.jar"]
    "/Users/pgowda/jars/foo/bar.jar"

"""

from __future__ import print_function
import glob
import os
import sys


def main():
    if len(sys.argv) < 2:
        searchfor = '/Users/pgowda/jars/*/*.jar'
    else:
        searchfor = sys.argv[1]
    jars = glob.glob(searchfor)
    print(os.pathsep.join(jars))


if __name__ == '__main__':
    main()
