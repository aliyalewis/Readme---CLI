class Book < ActiveRecord::Base
    has_many :readinglists
    has_many :users, through: :readinglists
end