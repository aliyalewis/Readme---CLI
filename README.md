# Readme---CLI

## How to Run Readme

1. Clone this repo onto your local system.
2. `cd` into "Readme---CLI" and type `rake run` into your command prompt or terminal and you're ready to start.

## How to Run the Test

1. Type `rspec spec/testing/ReadingListCLI_spec.rb` into the command prompt or terminal.

## Technologies

- Ruby
- Rake
- Rest Client
- Rspec

## Issues

As of the latest version of this app, if a user goes to check their reading list before a book has been added, the action will result in the app crashing or #save_book will run and then the app will crash.

When running the tests, the user must type in the number 3 in order for the test to pass.

There is also no way to exit the application outside of using `ctrl c` to end the program.

## Resources

- [RSpec without Rails](https://gist.github.com/maxivak/720fc38769c94a59893f)

- [Test Driven RSpec](https://www.youtube.com/watch?v=K6RPMhcRICE&t=63s)

- [Testing with RSpec](https://www.youtube.com/watch?v=71eKcNxwxVY&t=178s)

- [RSpec Tests for Beginners](https://medium.com/swlh/rspec-tests-for-beginners-a798c8bf6bac)

- [RSpec Test Doubles](https://www.tutorialspoint.com/rspec/rspec_test_doubles.htm)

- [How to Use Rspeck Mocks (Step-By-Step Tutorial)](https://www.rubyguides.com/2018/10/rspec-mocks/)