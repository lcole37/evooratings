require 'rails_helper'

RSpec.describe 'The User registration' do
  describe 'As a User' do
    describe 'When I visit the User Registration Page' do
      before(:each) do
        User.delete_all

        @user1 = User.create!(username: 'Mary', email: 'mary@gmail.com', password: 'password123', password_confirmation: 'password123')
        @user2 = User.create!(username: 'Larry', email: 'larry@hotmail.com', password: 'password123', password_confirmation: 'password123')
        @user3 = User.create!(username: 'Sherri', email: 'sherri@aol.com', password: 'password123', password_confirmation: 'password123')

        visit root_path
      end

      it 'I see a link to create a new user' do
        expect(page).to have_button "Create New Account"

        click_button 'Create New Account'
        expect(current_path).to eq(new_user_path)

        fill_in 'Username', with: 'Martin'
        fill_in 'Email', with: 'martin31@gmail.com'
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'password123'
        click_button 'Create Account'

        expect(current_path).to eq("/users/#{User.last.id}")
        expect(page).to have_content("Martin")
        expect(page).to_not have_content("Larry")
        expect(page).to_not have_content("Mary")
        expect(page).to_not have_content("Sherri")
      end

      it "checks for unique email address" do
        click_button('Create New Account')

        fill_in 'Username', with: "Mary"
        fill_in 'Email', with: "Mary@gmail.com"
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'password123'
        click_button 'Create Account'

        expect(current_path).to eq(register_path)
        expect(page).to have_content("Error: Email already linked with an account")
      end

      it "checks for matching passwords" do
        click_button('Create New Account')

        fill_in 'Username', with: "NewName"
        fill_in 'Email', with: "newemail@gmail.com"
        fill_in 'Password', with: 'password123'
        fill_in 'Password confirmation', with: 'notsamepassword'
        click_button 'Create Account'

        expect(current_path).to eq(register_path)
        expect(page).to have_content("Error: Password and confirmation must match")
      end
    end
  end
end
