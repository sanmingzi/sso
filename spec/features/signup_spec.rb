require 'rails_helper'

feature 'signup', js: true do
  def signup(username, email, password, password_confirmation)
    visit signup_path
    fill_in 'user_username', with: username
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'commit'
  end

  scenario 'with empty username', js: true do
    signup('', 'test@test.com', '123456', '123456')
    expect(page).to have_content('Sign up failed')
    expect(page).to have_content('username can\'t be blank')
  end

  scenario 'with empty email' do
    signup('test', '', '123456', '123456')
    expect(page).to have_content('Sign up failed')
    expect(page).to have_content('email can\'t be blank')
  end

  scenario 'with format error email' do
  end

  scenario 'with empty password' do
  end

  scenario 'with not match password confirmation' do
  end

  scenario 'success' do
    signup('test', 'test@test.com', '123456', '123456')
    expect(page).to have_content('sign up successfully')
  end
end
