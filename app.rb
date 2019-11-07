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
    all_books(books)
end

def all_books(books)
system('clear')
    max_list = []
    puts "I found these books:"

    books.each do |book|
        max_list << book
    end

    if max_list.length > 5
        max_list = max_list.slice(0, 5)
    end

    puts

    five_books(max_list)
end

def five_books(max_list)
    i = 1
    max_list.each do |book|
        puts "#{i}) #{book["volumeInfo"]["title"]}"
        puts "   Author(s):"
        book["volumeInfo"]["authors"].each do |author|
            puts "   #{author}"
        end

        puts "   Publisher: #{book["volumeInfo"]["publisher"]}"
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

    book_number = gets.chomp.to_i
    book_number = book_number - 1
    readinglist(max_list[book_number])
    
end

def readinglist(book_info)
    puts "Here's your reading list!"
    puts
    
    list = []
    list << book_info

    if list.length === 9
        puts "Your reading list is empty!"
    end

    list.each do |book|
        puts "#{book["volumeInfo"]["title"]}"
    end

end

search_query

binding.pry 

0


