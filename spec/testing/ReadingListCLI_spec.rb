# require 'json'
# require 'rest-client'

class ReadingListCLI
    attr_accessor :list

    def initialize
        @list = Array.new
        @max_list = Array.new
        @booklist = Array.new
    end

    def run
        puts "Welcome to ReadMe!"
        puts 
        menu_options
        get_input
        # search_query
        results = search_query
        short_list = all_books(results)
        save = five_books(short_list)
        number = save_book
        readinglist(save)
        search_menu
    end

# ------------ Book Searching ------------ 

    def get_input
        @user_input = STDIN.gets.chomp()
    end

    def search_query
        system("clear")
        puts "Please enter a book title:"
        get_input

        url = "https://www.googleapis.com/books/v1/volumes?q=#{@user_input.gsub(" ", "+")}"
        response = RestClient.get(url)
        json = JSON.parse(response)
        @books = json["items"]
        return @books
    end

    def all_books(books)
        system("clear")
        @max_list
        puts "I found these books:"

        books.each do |book|
            @max_list << book
        end

        if @max_list.length > 5
            @max_list = @max_list.slice(0, 5)
        end

        return @max_list
    end

    def five_books(list)
        @list = list

        i = 1
        @list.each do |book|
            puts "#{i}) #{book["volumeInfo"]["title"]}"
            puts '   Author(s):'

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
        return @list
    end

    # ------------ Reading List ------------ 

    def save_book
        puts
        puts "If you would like to save any of these books to your reading list please select the number of the  book."
        get_input
        @book_number = @user_input.to_i

        while @book_number != 1 && @book_number != 2 && @book_number != 3 && @book_number != 4 && @book_number != 5
            system("clear")
            puts "Please select a valid number"
            puts "----------------------------"
            puts
            break
        end

        return @book_number

    end

    def readinglist(*book_info)

        system("clear")
        @booklist

        if !book_info || !@book_number   
            puts "Your list is empty!"
            search_menu 
        elsif
            puts "#{book_info[0][@book_number - 1]["volumeInfo"]["title"]}"
            @booklist << book_info[@book_number - 1]["volumeInfo"]["title"]
            puts "Here's your reading list:"

            @booklist.each do |book|
                puts "#{book["volumeInfo"]["title"]}"
            end

            puts 
            search_menu
        end
    end

    # ------------ Menu Options ------------ 

    def menu_options
        prompt = "Enter S to search for books or L to see your reading list!"
        puts
        puts prompt
        get_input

        menu_selection = @user_input
        menu_select(menu_selection)
    end

    def search_menu
        puts 'Enter "B" to search for books:'
        get_input
        user_input = @user_input

        if user_input != "B"
            puts "Please chose a valid option."
            search_menu 
        elsif user_input === "B"
            search_query
        end
    end

    def menu_select(menu_selection)
        if menu_selection != "S" && menu_selection != "L"
            system("clear")
            puts "Please select a valid menu option."
            puts 
            menu_options
        elsif menu_selection === "S"
            search_query
        elsif menu_selection === "L"
            system("clear")
            readinglist()
        end
    end

end

RSpec.describe "ReadingListCLI" do

    context "#all_books" do
        it "should return an array with 5 books" do
            rl = ReadingListCLI.new

            book1 = double('book')
            book2 = double('book')
            book3 = double('book')
            book4 = double('book')
            book5 = double('book')
            book6 = double('book')

            allow(book1).to receive(:title) {'Where the Red Fern Grows'}
            allow(book2).to receive(:title) {'Gone Girl'}
            allow(book3).to receive(:title) {'Born a Crime'}
            allow(book4).to receive(:title) {'Brotopia'}
            allow(book5).to receive(:title) {'American Gods'}
            allow(book6).to receive(:title) {'Peter Pan'}
        
            books = [book1, book2, book3, book4, book5, book6]
            results = rl.all_books(books)
            expect(results.length). to eq 5
        end
    end

    context "#save_book" do
        it "checks that user input is valid" do
            rl = ReadingListCLI.new 

            number = rl.save_book
            allow($stdin).to receive(:gets).and_return(3)
            # numbers = $STDIN.gets 
            expect(number).to eq(3)
        end
    end

end