require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

    describe 'GET #index' do
      it 'returns HTTP staus success' do
        get :index
        expect(response).to have_http_status(:success)
      end
      it 'instantiates @top_11 categories variable' do
        get :index
        expect(assigns(:top_11)).to_not eq(nil)
      end
    end

    describe '#POST search' do
      it 'returns search results' do
        post :search, params: { search: 'Ruby on Rails' }
        expect(assigns(:snippets)).to_not eq(nil)
      end
      it 'renders the search template' do
        post :search, params: { search: 'PHP' }
        expect(response).to render_template :search
      end
    end

end
