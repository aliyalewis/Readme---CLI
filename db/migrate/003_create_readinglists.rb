class CreateReadinglists < ActiveRecord::Migration[5.0]

    def change
        create_table :readinglist do |t|
            t.integer :user_id
            t.integer :book_id
        end
    end

end