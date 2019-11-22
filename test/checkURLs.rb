require "net/http"

def url_exist?(url_string)
  if (url_string != 'https://hudson.eclipse.org/papyrus/job/papyrus-sysml16-master/lastSuccessfulBuild/artifact/releng/org.eclipse.papyrus.sysml16.p2/target/repository/') && (url_string != 'https://git-scm.com')
    url = URI.parse(url_string)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
  #  path = url.path if url.path.present?
    path = url.path
    res = req.request_head(path || '/')
    if res.kind_of?(Net::HTTPRedirection)
      url_exist?(res['location']) # Go after any redirect and make sure you can access the redirected URL
    else
      ! %W(4 5).include?(res.code[0]) # Not from 4xx or 5xx families
    end
  end
rescue Errno::ENOENT
  false #false if can't find the server
end
adocs = Regexp.new("\.adoc$") # asciidoc source file
defs = Regexp.new("\.txt$") # asciidoc source file
#re = Regexp.new("master.adoc")

dir = Dir.new('.')
dir.each  {|fn|
    if ( fn =~ adocs ) || (fn =~ defs) then
        print "----------------------------------\n"
        print "asciidoc source : " + fn + "\n"
        paths = []
        # find all urls anywhere
        File.open(fn) { |f|
            content = f.read
            paths = content.scan(/http[s]:\/\/[^\["\n]*/)
#            paths = content.scan(/image::?([^\[ ]+)\[/)
        }
        paths.flatten.each {|path|
            print "Checking " + path  + "\n"
            print (url_exist?(path) ? " OK " : " NOK ") + path + "\n"
        }
    end
}
