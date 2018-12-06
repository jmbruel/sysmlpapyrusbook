require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

desc "Install necessary pdf, epub3 asciidoctor gems"
task :default do
  install_plugin("asciidoctor-epub3")
  install_plugin("asciidoctor-pdf")
end

desc "Create different file outputs"
task :ascii  do
  system("asciidoctor -o output/master.html master.adoc")
  system("asciidoctor-epub3 -D output master.adoc")

  system("asciidoctor-pdf -a final -o output/master.pdf master.adoc ")
end

def install_plugin(name)
  git_clone("https://github.com/asciidoctor/#{name}")
  cd(name) do
    build_gem
  end
end

def git_clone(repo)
  sh("git", "clone", repo)
end
def build_gem
  sh('bundle')
  sh('rake', 'build')
  system('gem install pkg/*.gem')
end

desc "Launch tests before CI"
task :test  do
  system("ruby test/figures_test.rb")
end


Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end