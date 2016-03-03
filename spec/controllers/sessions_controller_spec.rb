require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create(:user) }

  def login
    @user = user
    request.session[:user_id] = @user.id
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
    it 'instantiates a new User variable @user' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    context ' with valid credentials' do
      it 'sets the session[:user_id] to the returning user id' do
        login
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    context 'with invalid credentials' do
      it 'renders the new template' do
        post :create, user: attributes_for(:user, first_name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_request
      delete :destroy, id: user.id
    end
    context ' with user signed in' do
      before { login }
      it 'deletes the session[:user_id]' do
        delete_request
        expect(session[:user_id]).to_not be
      end
      it 'redirects to the root path' do
        delete_request
        expect(response).to redirect_to root_path
      end
    end

    context 'with no user logged in' do
      it 'redirect to the new session path' do
        delete_request
        expect(response).to redirect_to new_session_path
      end
    end
  end
end
