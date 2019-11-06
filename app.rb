require 'rest-client'
require 'pry'

puts "Please enter a book title"
user_input = gets.chomp

url = "https://www.googleapis.com/books/v1/volumes?q=#{user_input.gsub(" ", "+")}"

response = RestClient.get(url)

json = JSON.parse(response)

books = json['items']

books.each do |book| 
    title = book["items"][0]["volumeInfo"]["title"]
    author = book["items"][0]["volumeInfo"]["author"]
    publisher = book["items"][0]["volumeInfo"]["publisher"]
end



Pry.start
