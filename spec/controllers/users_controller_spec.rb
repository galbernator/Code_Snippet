require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }

  def login
    request.session[:user_id] = user.id
  end

  describe 'GET #new' do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
    it "instantiates a new User variable" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      def valid_request
        post :create, user: {
          first_name: 'Rick',
          last_name: 'Rickerson',
          email: 'me@mail.com',
          password: 'abcd1234'
        }
      end
      it 'creates a new User in the database' do
        expect { valid_request }.to change { User.count }.by(+1)
      end
      it 'redirects to root path' do
        valid_request
        expect(response).to redirect_to root_path
      end
      it 'sets the session[:user_id] to the newly created user' do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end
    end
    context 'with invalid params' do
      def invalid_request
        post :create, user: {
          first_name: 'Rick',
          password: 'abcd1234'
        }
      end
      it 'does not create a new User record in the database' do
        expect { invalid_request }.to_not change { User.count }
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    context 'with user signed in' do
      before do
        login
      end
      def valid_request
        get :edit, id: user.id
      end
      it 'instantiates @user with the requested user' do
        valid_request
        expect(assigns(:user)).to eq(user)
      end
      it 'renders the edit template' do
        valid_request
        expect(response).to render_template :edit
      end
    end

    context 'with user not signed in' do

    end
  end

  describe 'PATCH #update' do
    context 'with user signed in' do
      before do
        login
      end
      context 'with valid params' do
        def valid_request
          patch :update, id: user.id, user: { email: 'me@mail.com', current_password: 'abcdef123'}
        end
        it 'updates the existing record' do
          valid_request
          expect(user.reload.email).to eq('me@mail.com')
        end
      end

      context 'with invalid params' do
        def invalid_request
          patch :update, id: user.id, user: { first_name: '', last_name: 'Smitherson' }
        end
        it 'does not update the record' do
          expect(user.reload.last_name).to_not eq('Smitherson')
        end
        it 'renders the exit template' do
          invalid_request
          expect(response).to render_template :edit
        end
      end
    end

    context 'with user not signed in' do
      it 'redirects to path' do
        patch :update, id: user.id, user: {
          first_name: 'Frank',
          last_name: 'Frankerson',
          email: 'frank@mail.com',
          password: 'abcd1234'
        }
        expect(response).to redirect_to new_session_path
      end
    end
  end

end
