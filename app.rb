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

    if max_list.length > 5
        max_list = max_list.slice(0, 5)
    end

    puts 
    puts

    i = 1

    max_list.each do |book|
        puts "#{i}) #{book["volumeInfo"]["title"]}"
        # puts "  Author(s): #{book["volumeInfo"]["authors"][0]}"
        puts "Author(s):"
        book["volumeInfo"]["authors"].each do |author|
            puts "#{author}"
        end

        puts "  Publisher: #{book["volumeInfo"]["publisher"]}"
        puts
        i += 1
    end
   
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


