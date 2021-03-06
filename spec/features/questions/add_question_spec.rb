require_relative '../feature_helper'

feature 'Add question', %q{
	In order to get answer from community
	As a user
	I want to be able to ask a question
} do
	given!(:user) { create(:user) }

	context 'Authenticated user tries to' do
		before(:each) do
			sign_in user
			visit questions_path
		end

		scenario 'add a new question', js: true do
			click_on 'Ask question'
			fill_in 'Title', with: 'Testing question.'
			fill_in 'Body', with: 'Can you give a simple answer?'
			click_on 'Create question'

			expect(page).to have_content 'Your question was successfully created.'
			expect(page).to have_content 'Can you give a simple answer?'
		end

		scenario 'add a new question with tags', js: true do
			click_on 'Ask question'
			fill_in 'Title', with: 'Testing tags.'
			fill_in 'Body', with: 'Ok lets try adding tags.'
			find('.bootstrap-tagsinput input').set('pizza, hut')
			click_on 'Create question'

			within('#question #tags') do
				expect(page).to have_content 'pizza'
				expect(page).to have_content 'hut'
			end
		end

		scenario 'add an invalid new question', js: true do
			click_on 'Ask question'
			fill_in 'Title', with: nil
			fill_in 'Body', with: 'Can you give a simple answer?'
			click_on 'Create question'

			expect(page).to have_content "can't be blank"
		end
	end

	context 'Non-authenticated user tries to', js: true do
		scenario 'add a new question' do
			visit questions_path

			expect(page).not_to have_link 'Ask question'
		end
	end
end