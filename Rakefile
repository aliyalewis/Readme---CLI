require_relative './config/environment.rb'
require 'sinatra/activerecord/rake'

desc 'start a console'
task :console do
    Pry.start
end

task :run do
    books = ReadingListCLI.new
    books.run
end