class User < ActiveRecord::Base
    has_many :readinglists
    has_many :books, through: :readinglists
end