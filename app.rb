require 'rest-client'
require 'pry'


# ------------ Book Searching ------------ 

puts "Welcome to ReadMe!"
puts 

def search_query
    puts "Please enter a book title:"
    user_input = gets.chomp

    url = "https://www.googleapis.com/books/v1/volumes?q=#{user_input.gsub(" ", "+")}"
    response = RestClient.get(url)
    json = JSON.parse(response)
    books = json['items']
    show_books(books)
end

def show_books(books)
    max_list = []
    puts "-------------------"

    books.each do |book|
        max_list << book
    end


    puts 
    puts

    puts "1) #{max_list[0]["volumeInfo"]["title"]}"
    puts "  Author: #{max_list[0]["volumeInfo"]["authors"][0]}"
    puts "  Publisher: #{max_list[0]["volumeInfo"]["publisher"]}"
    puts
    puts "2) #{max_list[1]["volumeInfo"]["title"]}"
    puts "  Author: #{max_list[1]["volumeInfo"]["authors"][0]}"
    puts "  Publisher: #{max_list[1]["volumeInfo"]["publisher"]}"
    puts
    puts "3) #{max_list[2]["volumeInfo"]["title"]}" 
    puts "  Author: #{max_list[2]["volumeInfo"]["authors"][0]}"
    puts "  Publisher: #{max_list[2]["volumeInfo"]["publisher"]}"
    puts
    puts "4) #{max_list[3]["volumeInfo"]["title"]}" 
    puts "  Author: #{max_list[3]["volumeInfo"]["authors"][0]}"
    puts "  Publisher: #{max_list[3]["volumeInfo"]["publisher"]}"
    puts
    puts "5) #{max_list[4]["volumeInfo"]["title"]}"
    puts "  Author: #{max_list[4]["volumeInfo"]["authors"][0]}"
    puts "  Publisher: #{max_list[4]["volumeInfo"]["publisher"]}"
    save_book(max_list)
end

# ------------ Reading List ------------ 

def save_book(max_list)
    puts
    puts "If you would like to save any of these books to your reading list
    please select the number of the  book."
end


search_query

binding.pry 

0


