# require '../lib/ReadingListCLI.rb'
class ReadingListCLI
    attr_accessor :list, :books

    def initialize
        @list = Array.new
        @books = Array.new
        @max_list = Array.new
    end

    def run
        puts "Welcome to ReadMe!"
        puts 
        menu_options
        get_input
        all_books
        five_books
        readinglist
        save_book
        readinglist
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
    end

    def all_books
        system("clear")
        @max_list = []
        puts "I found these books:"

        @books.each do |book|
            @max_list << book
        end

        if @max_list.length > 5
            @max_list = @max_list.slice(0, 5)
        end

        puts
        @max_list
    end

    def five_books
        all_books
        i = 1
        @max_list.each do |book|
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

        # readinglist(list)
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

    end

    def readinglist(book_info = "undefined")
        save_book
        system("clear")
        # list
        @list << book_info[@book_number - 1]["volumeInfo"]["title"]
        puts "Here's your reading list:"
        puts

        if @list.length == 0
            puts "Your list is empty!"
        elsif list
            @list.each do |book|
                puts "#{book}"
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




RSpec.describe ReadingListCLI do 
    context 'Book Searching Section' do
        it '#all_books returns all book search results' do 
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

            @max_list = [book1, book2, book3, book4, book5, book6]
            results = @max_list
            expect(results.length).to be 6
        end
    end
end