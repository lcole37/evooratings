require 'rails_helper'

RSpec.describe "User Log In" do
  it 'can log in a user with correct credentials' do
    @user = User.create(username: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"

    click_button "Log in as Existing User"

    expect(current_path).to eq(login_path)

    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'

    expect(current_path).to eq(user_path(@user))

    expect(page).to have_content("Welcome User One")
    expect(page).to have_content("User One's Dashboard")
  end

  it 'will not log in a user with incorrect password' do
    @user = User.create(username: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"

    click_button "Log in as Existing User"

    expect(current_path).to eq(login_path)

    fill_in :email, with:'email@example.com'
    fill_in :password, with: 'incorrectpassword'
    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Bad Credentials")
  end

  it 'will not log in a user with incorrect email' do
    @user = User.create(username: 'User One', email: 'email@example.com', password: 'password123')

    visit "/"

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with:'bademail@example.com'
    fill_in :password, with: 'password123'
    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Bad Credentials")
  end
end
