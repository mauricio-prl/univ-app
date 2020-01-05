require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http ok" do
      get :new

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      let!(:student) { create(:student, email: 'email@email.com', password: 'password') }

      subject { 
        post :create, params: {
          session: {
            email: 'email@email.com',
            password: 'password'
          }
        }
      }

      it 'has session[:user_id]' do
        subject

        expect(session[:student_id]).to eq(student.id)
      end

      it "returns the flash message" do
        subject

        expect(flash[:notice]).to match(/You have successfully logged in./)
      end

      it 'redirects to student_path' do
        subject

        expect(response).to redirect_to(student_path(student))
      end
    end

    context 'when invalid attributes' do
      let!(:student) { create(:student, email: 'email@email.com', password: 'password') }

      subject { 
        post :create, params: {
          session: {
            email: 'email@email.com',
            password: 'another-password'
          }
        }
      }

      it 'does not have session[:student_id]' do
        subject

        expect(session[:student_id]).to eq(nil)
      end

      it 'has flash error' do
        subject

        expect(flash[:alert]).to eq('There was something wrong with your login information.')
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:student) { create(:student) }

    subject { delete :destroy, params: { id: student.id } }

    before do
      login(student)
    end

    it "logs out the student" do
      expect(session[:student_id]).to eq(student.id)
      subject

      expect(session[:student_id]).to eq(nil)
    end

    it 'has flash notice' do
      subject

      expect(flash[:notice]).to eq('You have logged out.')
    end
  end
end
