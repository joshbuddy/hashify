libdir = File.expand_path("lib")
$:.unshift(libdir) unless $:.include?(libdir)

require 'hashify'