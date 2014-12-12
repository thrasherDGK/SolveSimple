require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
	let(:question) { create(:question) }

	describe 'GET #index' do
		let(:questions) { create_list(:question, 2) }

		before { get :index }

		it 'populates an array of  all questions' do
			expect(assigns(:questions)).to match_array(questions)
		end

		it 'renders the :index template' do
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		before { get :show, id: question }

		it 'assigns requested question to @question' do
			expect(assigns(:question)).to eq question
		end

		it 'renders the :show template' do
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		before { get :new }

		it 'it assigns new Question to @question' do
			expect(assigns[:question]).to be_a_new(Question)
		end

		it 'renders the :new template' do
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		before { get :edit, id: question }

		it 'assigns requested question to @question' do
			expect(assigns(:question)).to eq question
		end

		it 'renders the :edit template' do
			expect(response).to render_template :edit
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves the new question in the database' do
				expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
			end

			it 'redirects to questions#show' do
				post :create, question: attributes_for(:question)
				expect(response).to redirect_to question_path(assigns(:question))
			end
		end

		context 'with invlid attributes' do
			it 'does not save the new question in the database' do
				expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
			end
			it 're-renders the :new template' do
				post :create, question: attributes_for(:invalid_question)
				expect(response).to render_template :new
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it 'assigns requested question to @question' do
				patch :update, id: question, question: attributes_for(:question)
				expect(assigns(:question)).to eq question
			end

			it "changes @question's attributes" do
				patch :update, id: question, question: { title: 'New Title', body: 'New body' }
				question.reload
				expect(question.title).to eq 'New Title'
				expect(question.body).to eq 'New body'
			end

			it 'redirects to updated question' do
				patch :update, id: question, question: attributes_for(:question)
				expect(response).to redirect_to question
			end
		end

		context 'with invalid attributes' do
			let(:question) { create(:question, body: 'Some old body') }

			before { patch :update, id: question, question: { title: 'New Title', body: nil } }

			it "does not change @question's attributes" do
				question.reload
				expect(question.title).to_not eq 'New Title'
				expect(question.body).to eq 'Some old body'
			end

			it 're-renders the :edit template' do
				expect(response).to render_template :edit
			end
		end
	end

	describe 'DELETE #destroy' do
		before { question }

		it 'deletes the question from the database' do 
			expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
		end
		
		it 'redirects to questions#index' do
			delete :destroy, id: question
			expect(response).to redirect_to questions_path
		end
	end
end


















