require_relative 'feature_helper'

feature 'User sign in', %q{
	In order to be able to ask question
	As a user
	I want to be able to sign in
} do

	scenario 'Registered user tries to sign in' do
		user = create(:user)

		sign_in user

		expect(page).to have_content 'Signed in successfully.'
		expect(current_path).to eq root_path
	end

	scenario 'Non-registered user tries to sign in' do
		visit root_path
		click_on 'Login'
		fill_in 'Email', with: 'newuser@example.com'
		fill_in 'Password', with: 'secret123'
		click_on 'Log in'

		expect(page).to have_content 'Invalid email or password.'
		expect(current_path).to eq new_user_session_path
	end
end