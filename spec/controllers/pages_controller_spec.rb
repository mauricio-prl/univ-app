require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #index' do
    it 'returns http status ok' do
      get :about

      expect(response).to have_http_status(:ok)
    end
  end
end
