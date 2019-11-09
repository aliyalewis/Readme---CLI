require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    it 'checks for the presence of a name' do 
      user = User.new(email: "email@email.com").save
      expect(user).to eq(false)
    end

    it 'checks for the presence of an email' do
      user = User.new(name: 'name').save
      expect(user).to eq(false)
    end

    it 'saves successfully' do
      user = User.new(name: 'Aname', email: "aname@email.com").save
      expect(user).to eq(true)
    end
  end

end