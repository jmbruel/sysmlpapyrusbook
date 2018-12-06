# encoding: UTF-8

ASCIIDOCTOR_PROJECT_DIR = '/Users/jmb/localdev/asciidoctor'
#Dir.chdir ASCIIDOCTOR_PROJECT_DIR

if RUBY_VERSION < '1.9'
  require 'rubygems'
end

require 'rspec/expectations'
require File.join(ASCIIDOCTOR_PROJECT_DIR, 'lib', 'asciidoctor')

Given("I have an {string} page that contains {string}") do |string, string2|
    File.file?(string) && (File.readlines(string).grep(/#{string2}/).size > 0)
end
  
Given("I have an images directory") do
    File.directory?("images")
end
  
When /I generate HTML/ do
    @output = Asciidoctor.convert File.readlines('master.adoc')
end
  
Then("I should get a zero exit status") do
    pending # Write code here that turns the phrase above into concrete actions
end

Then("The {string} file should exist") do |string|
    #expect(page).to have_content("Hello Cucumber")
    expect(File.file?(string)).to be false
end