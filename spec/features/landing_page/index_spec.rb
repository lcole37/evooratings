require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    # User.delete_all
    @user1 = User.create(username: "User One", email: "user1@test.com", password: "password1")
    @user2 = User.create(username: "User Two", email: "user2@test.com", password: "password2")
    visit '/'
  end

  it 'has a header' do
    expect(page).to have_content('EvooRatings')
  end

  it 'has link to create new user' do
    click_button "Create New Account"

    expect(current_path).to eq(new_user_path)
  end

  it "has a navbar with: link to homepage" do
    visit '/'

    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it "Has a link to 'Log In as existing user'" do
    click_button "Log in as Existing User"

    expect(current_path).to eq(login_path)
  end

  it "Has a link to user's favorites when user is logged in" do
    click_button "Log in as Existing User"
    fill_in :email, with:'user1@test.com'
    fill_in :password, with: 'password1'
    click_button 'Log In'

    expect(current_path).to eq(user_path(@user1))
    #
    # save_and_open_page
    # click_link "Home"
    #
    # expect(page).to have_link("My Favorites")
    # #
    # click_link "My Favorites"
    #
    # expect(current_path).to eq(user_favorites_path(@user1))
  end
end
