require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'start a console'
task :console do
    Pry.start
end

task :run do
    books = ReadingListCLI.new
    books.run
end