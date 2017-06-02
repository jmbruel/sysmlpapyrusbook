#require 'minitest/spec'
require 'minitest/autorun'

re = Regexp.new("\.html$") # asciidoc source file

dir = Dir.new('./output')
dir.each  {|fn|
    if ( fn =~ re ) then
        print "asciidoc source : " + fn + "\n"
        paths = []
        # find all image: or image:: asciidoc macros
        File.open(fn) { |f|
          p 'opening ' << fn
            content = f.read
            paths = content.scan(/<img src="([^"]*)"/)
        }
        imagesDir='../images'
        # test that path is a file
        paths.flatten.each {|path|
          # remove from test every online figure (such as Github status)
          if path != "https://travis-ci.org/jmbruel/sysmlpapyrusbook.svg?branch=master"
            describe File do
              it "should exist " + path + " in the {images} directory" do
                assert_equal File.file?(path), true
              end
            end
          end
        }
    end
}
