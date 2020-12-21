require 'rails_helper'

feature 'signup' do
  def signup(username, email, password, password_confirmation)
    visit signup_path
    fill_in 'user_username', with: username
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'commit'
  end

  scenario 'success' do
    signup('test', 'test@test.com', '123456', '123456')
    expect(page).to have_content('sign up successfully')
  end

  scenario 'with empty username' do
  end

  scenario 'with empty email' do
  end

  scenario 'with format error email' do
  end

  scenario 'with empty password' do
  end

  scenario 'with not match password confirmation' do
  end
end
