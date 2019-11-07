require_relative '../config/environment'

class ReadingListCLI

# ------------ Book Searching ------------ 

    puts "Welcome to ReadMe!"
    puts 


    def search_query
        system('clear')
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

        book_number = gets.chomp.to_i
        book_number = book_number - 1

        while book_number != 1 && book_number != 2 && book_number != 3 && book_number != 4 && book_number != 5
            system('clear')
            puts "Please select a valid number"
            puts "----------------------------"
            puts
            five_books(max_list)
            break
        end

        readinglist(max_list[book_number])
        
    end

    def readinglist2 
        
    end

    def readinglist(book_info)
        system('clear')
        puts "Here's your reading list:"
        puts

        list = []
        list << book_info

        if list.length === 0 || list === []
            empty_list
        elsif
            list.each do |book|
                puts "#{book["volumeInfo"]["title"]}"
            end
        end
        menu_options

    end

    def empty_list
        puts "Here's your reading list:"
        puts
        puts "Your list is empty!"
    end

    # ------------ Menu Options ------------ 

    def menu_options
        prompt = "Press S to search for books or L to see your reading list!"
        puts
        puts prompt

        menu_selection = gets.chomp
        menu_select(menu_selection)
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
            empty_list
            menu_options
        end
    end

end