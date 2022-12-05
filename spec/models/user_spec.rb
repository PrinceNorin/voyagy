require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  it 'should generate api_key' do
    user.save
    expect(user.api_key).not_to be_nil
  end

  it 'should down case email' do
    email = user.email.upcase
    user.email = email
    user.save
    expect(user.email).to eq(email.downcase)
  end

  context 'password validation' do
    it 'should validate password length for new user' do
      user.password = '123'
      expect(user).not_to be_valid
      expect(user.errors[:password]).not_to be_empty
    end

    it 'should validate password length if presented' do
      expect(user).to be_valid
      user.save

      user.password = '123'
      expect(user).not_to be_valid
      expect(user.errors[:password]).not_to be_empty
    end
  end
end
