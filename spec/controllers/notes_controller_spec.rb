require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  def login
    @user = create(:user, role: 'admin', password: 'Things!')
    request.session[:user_id] = @user.id
  end

  describe 'Note' do
    it 'is a valid note' do
      expect(build(:note)).to be_valid
    end
  end

  describe 'GET #index' do
    context 'with user signed in' do
      before do
        login
      end
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
      it 'set an instance variable @notes' do
        @notes = [create(:note, user_id: @user.id)]
        get :index
        expect(assigns(:notes)).to eq(@user.notes)
      end
    end

    context 'user not signed in' do
      it 'redirects to the login page' do
        get :index
        expect(response).to have_http_status 302
      end
      it 'redners the new session template' do
        get :index
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'POST #create' do
    def valid_request
      post :create, note: attributes_for(:note), format: 'js'
    end
    context 'with user logged in' do
      before do
        login
      end
      it 'creates a new note in the database' do
        expect { post :create, note: attributes_for(:note, user_id: @user.id), format: 'js' }.to change { Note.count }.by(+1)
      end
    end

    context 'user not logged in' do
      it 'does not create a new note in the database' do
        expect { valid_request }.to_not change { Note.count }
      end
      it 'redirects to the login page' do
        valid_request
        expect(response).to have_http_status 302
      end
      it 'redners the new session template' do
        valid_request
        expect(response).to redirect_to new_session_path
      end
    end

    context 'invalid parameters' do
      before do
        login
      end
      def invalid_request
        post :create, note: attributes_for(:note, title: nil), format: 'js'
      end
      it 'does not add a new note to the database' do
        expect { invalid_request }.to_not change { Note.count }
      end
    end
  end

end
