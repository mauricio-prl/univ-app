require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    it 'returns http status ok' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    it 'returns http status ok' do
      get :new

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'when valid attributes' do
      subject {
        post :create, params: {
          course: {
            short_name: 'CD123',
            name: 'Some course',
            description: 'Some description'
          }
        }
      }

      it 'creates the course' do
        expect{ subject }.to change(Course, :count).by(1)
      end

      it 'has flash notice' do
        subject

        expect(flash[:notice]).to eq('Course successfully created.')
      end

      it 'redirects to root' do
        subject

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when invalid attributes' do
      subject {
        post :create, params: {
          course: {
            short_name: nil,
            name: 'Some course',
            description: 'Some description'
          }
        }
      }

      it 'does not create the course' do
        expect{ subject }.not_to change(Course, :count)
      end

      it 'render new' do
        subject

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    let!(:course) { create(:course) }

    it 'has have_http_status ok' do
      get :show, params: { id: course.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit' do
    let!(:course) { create(:course) }

    it 'has have_http_status ok' do
      get :edit, params: { id: course.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    let!(:course) { create(:course) }

    context 'when valid attributes' do
      subject { 
        put :update, params: {
          id: course.id, course: {
            short_name: 'GG123',
            name: 'New name',
            description: 'New description'
          }
        }
      }

      it 'updates the course' do
        subject
        course.reload

        expect(course.short_name).to eq('GG123')
        expect(course.name).to eq('New name')
        expect(course.description).to eq('New description')
      end

      it 'has the flash notice' do
        subject

        expect(flash[:notice]).to eq('Course successfully updated.')
      end

      it 'redirects to root' do
        subject

        expect(response).to redirect_to(course)
      end
    end

    context 'when invalid attributes' do
      subject { 
        put :update, params: {
          id: course.id, course: {
            short_name: nil,
            name: nil,
            description: nil
          }
        }
      }

      it 'does not update the course' do
        subject
        course.reload

        expect(course.short_name).not_to eq(nil)
        expect(course.name).not_to eq(nil)
        expect(course.description).not_to eq(nil)
      end

      it 'render edit' do
        subject

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:course) { create (:course) }

    subject {
      delete :destroy, params: { id: course.id }
    }

    it 'deletes the course' do
      expect{ subject }.to change(Course, :count).by(-1)
    end

    it 'has the flash notice' do
      subject

      expect(flash[:notice]).to eq('Course successfully deleted.')
    end
  end
end
