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
end
