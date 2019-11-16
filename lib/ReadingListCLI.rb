require_relative '../config/environment'

class ReadingListCLI
    attr_accessor :list

    def initialize
        @list = Array.new
    end

    def run
        puts "Welcome to ReadMe!"
        puts 
        menu_options
    end

# ------------ Book Searching ------------ 

    def search_query
        system('clear')
        puts "Please enter a book title:"
        user_input = STDIN.gets.chomp()

        url = "https://www.googleapis.com/books/v1/volumes?q=#{user_input.gsub(" ", "+")}"
        response = RestClient.get(url)
        json = JSON.parse(response)
        puts "Hi: #{json["kind"]}"

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

            if book["volumeInfo"]["authors"] 
                authors = book["volumeInfo"]["authors"]
            end

            if authors === nil
                puts "   no author(s) found"
            elsif authors.length > 0
                book["volumeInfo"]["authors"].each do |author|
                    puts "   #{author}"
                end
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
        puts "If you would like to save any of these books to your reading list please select the number of the  book."

        book_number = STDIN.gets.chomp()
        book_number = book_number.to_i
        puts "#{book_number}"

        while book_number != 1 && book_number != 2 && book_number != 3 && book_number != 4 && book_number != 5
            system('clear')
            puts "Please select a valid number"
            puts "----------------------------"
            puts
            five_books(max_list)
            break
        end

        readinglist(max_list[book_number - 1])
    end

    def readinglist(book_info = "undefined")
        system('clear')
        puts "Here's your reading list:"
        puts

        list << book_info

        if list[0] == "undefined"
            puts "Your list is empty!"
        elsif list
            list.each do |book|
                puts "#{book["volumeInfo"]["title"]}"
            end
        end
        
        puts 
        search_menu
    end

    # ------------ Menu Options ------------ 

    def menu_options
        prompt = "Enter S to search for books or L to see your reading list!"
        puts
        puts prompt

        menu_selection = STDIN.gets.chomp()
        menu_select(menu_selection)
    end

    def search_menu
        puts 'Enter "B" to search for books:'
        user_input = STDIN.gets.chomp()

        if user_input != "B"
            puts "Please chose a valid option."
        elsif user_input === "B"
            search_query
        end
    end

    def menu_select(menu_selection)
        if menu_selection != "S" && menu_selection != "L"
            system('clear')
            puts "Please select a valid menu option."
            puts 
            menu_options
        elsif menu_selection === "S"
            search_query
        elsif menu_selection === "L"
            system('clear')
            readinglist()
        end
    end

end