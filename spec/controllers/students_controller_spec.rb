require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "GET #index" do
    it "returns http ok" do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #new" do
    it "returns http ok" do
      get :new

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context 'when valid atributes' do
      subject { 
        post :create, params: {
          student: {
            name: 'Test',
            email: 'test@email.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      }

      it 'creates the student' do
        expect{ subject }.to change(Student, :count).by(1)
      end

      it 'has flash notice' do
        subject

        expect(flash[:notice]).to eq('Student successfully created.')
      end

      it 'redirects to students' do
        subject

        expect(response).to redirect_to(students_path)
      end
    end

    context 'when invalid atributes' do
      subject { 
        post :create, params: {
          student: {
            name: nil,
            email: 'invalid.email.com',
            password: nil
          }
        }
      }

      it 'does not create the student' do
        expect{ subject }.not_to change(Student, :count)
      end

      it 'renders new' do
        subject

        expect(response).to render_template(:new)
      end
    end

    context 'when the password does not match with password confirmation' do
      subject { 
        post :create, params: {
          student: {
            name: 'Some name',
            email: 'valid.email@email.com',
            password: 'password',
            password_confirmation: nil
          }
        }
      }

      it 'does not creates the student' do
        expect{ subject }.not_to change(Student, :count)
      end

      it 'renders new' do
        subject

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    let!(:student) { create(:student) }

    it "returns http ok" do
      get :show, params: { id: student.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #edit" do
    let!(:student) { create(:student) }

    it "returns http ok" do
      get :edit, params: { id: student.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #update" do
    let!(:student) { create(:student) }

    context 'when valid atributes' do
      subject {
        put :update, params: {
          id: student.id, student: {
            name: 'New name',
            email: 'new-email@test.com',
            password: 'new-passord',
            password_confirmation: 'new-passord'
          }
        }
      }

      it 'updates the student' do
        subject
        student.reload

        expect(student.name).to eq('New name')
        expect(student.email).to eq('new-email@test.com')
        expect(student.authenticate('new-passord')).to eq(student)
      end

      it 'has flash notice' do
        subject

        expect(flash[:notice]).to eq('Student successfully updated.')
      end

      it 'redirects to students' do
        subject

        expect(response).to redirect_to(student)
      end
    end

    context 'when invalid atributes' do
      subject {
        put :update, params: {
          id: student.id, student: {
            name: nil,
            email: nil
          }
        }
      }

      it 'does not update the student' do
        subject
        student.reload

        expect(student.name).not_to eq(nil)
        expect(student.email).not_to eq(nil)
      end
    end

    context 'when password does not match with password confirmation' do
      subject {
        put :update, params: {
          id: student.id, student: {
            name: 'New name',
            email: 'new_email@test.com',
            password: 'new-password',
            password_confirmation: 'another-password'
          }
        }
      }

      it 'does not update the student' do
        subject
        student.reload

        expect(student.name).not_to eq('New name')
        expect(student.email).not_to eq('new_email@test.com')
      end
    end
  end

  describe "GET #destroy" do
    let!(:student) { create(:student) }

    subject { 
      delete :destroy, params: {
        id: student.id
      }
    }

    it "deletes the student" do
      expect{ subject }.to change(Student, :count).by(-1)
    end

    it 'has flash notice' do
      subject

      expect(flash[:notice]).to eq('Student successfully deleted.')
    end

    it 'renders students' do
      subject

      expect(response).to redirect_to(students_path)
    end
  end
end
