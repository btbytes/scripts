#!/usr/bin/env ruby
require 'webrick'
require 'webrick/httpproxy'
require 'getoptlong'

opts = GetoptLong.new(
    [ "--help",  "-h", GetoptLong::NO_ARGUMENT       ],
    [ "--file",  "-f", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--port",  "-p", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--delay", "-d", GetoptLong::REQUIRED_ARGUMENT ]
)

def showHelp
    puts "Act as a transparent proxy that delays certain sites from loading"
    puts "\t-h or --help  Display this help"
    puts "\t-f or --file  Specify a file to load sites from"
    puts "\t-p or --port  Specify the port to accept connections on (default 8080)"
    puts "\t-d or --delay Specify the number of seconds to sleep when accesing a \"slow\" site (default 5 seconds)"
end

$sites = []
$port  = 8080
$delay = 5

opts.each do |opt, arg|
    case opt
    when "--help"
        showHelp
        exit
    when "--port"
        $port = arg.to_i
    when "--file"
        begin
            fdata = File.read(arg)
            fdata.split(/\n/).each do |site|
                $sites << site
            end
        rescue
            puts "Failed to load file #{arg} - #{$!}"
            exit
        end
    when "--delay"
        $delay = arg.to_i
    else
        puts "Invalid argument - #{opt}"
        showHelp
        exit
    end
end

while site = ARGV.shift
    $sites << site
end

if $sites.size ==0
    puts "You have not specified any sites to delay from loading.  There is no purpose to proxy transparently."
    showHelp
    exit
end

puts "Delaying the following sites from loading:"
$sites.each do |site|
    puts "\t#{site}"
end

$proxy = WEBrick::HTTPProxyServer.new\
    :Port            => $port,
    :ServerType      => Thread,
    :RequestCallback => Proc.new { |req,res|
        puts "[+] Parsing request #{req.request_line}"
        delay = false
        $sites.each do |site|
            if req.request_line.match(site)
                delay=true
                break
            end
        end
        if delay
            puts "\tThis is a \"slow\" site, sleeping for #{$delay} seconds"
            sleep $delay
        end
    }

$proxy.start

trap("INT") {
    puts "Shutting down..."
    $done = true
}

until $done
    # Idle loop
    sleep(1)
end

$proxy.shutdown
