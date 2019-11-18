require 'bundler'
require 'active_record'
Bundler.require

require_relative '../lib/ReadingListCLI.rb'
require_relative '../lib/models/user.rb'
require_relative '../lib/models/book.rb'
require_relative '../lib/models/readinglist.rb'


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
# ActiveRecord::Base.logger = nil