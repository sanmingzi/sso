require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates username' do
    user_params = {username: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456'}
    it 'presence' do
      user_params.delete(:username)
      user = User.new(user_params)
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors[:username]).to eq(['can\'t be blank'])
    end

    it 'uniqueness' do
      user_params0 = {username: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456'}
      user_params1 = {username: 'test', email: 'test1@test.com', password: '1234561', password_confirmation: '1234561'}
      User.create!(user_params0)
      user = User.new(user_params1)
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.errors[:username]).to eq(['has already been taken'])
    end
  end
end
