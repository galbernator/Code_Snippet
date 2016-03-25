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
      it 'does not show the notes that dont belong to the user' do
        @note_1 = create(:note, user_id: @user.id)
        user = create(:user)
        @note_2 = create(:note, user_id: user.id)
        get :index
        expect(assigns(:notes)).to eq([@note_1])
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

  describe 'GET #show' do
    context 'when user is owner of the note' do
      before do
        login
        @note = create(:note, user_id: @user.id)
      end
      it 'loads the show template' do
        get :show, id: @note.id
        expect(response).to render_template :show
      end
      it 'instantiates the variable @note' do
        get :show, id: @note.id
        expect(assigns(:note)).to eq(@note)
      end
    end

    context 'when user logged in but not note owner' do
      before do
        user = create(:user)
        @note = create(:note, user_id: user.id)
      end
      it 'raises an ActiveRecord::RecordNotFound error' do
        login
        expect do
          get :show, id: @note.id
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is not logged in' do
      before do
        user = create(:user)
        @note = create(:note, user_id: user.id)
      end
      it 'redirects to the new session path' do
        get :show, id: @note.id
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is owner of the note' do
      before do
        login
        @note = create(:note, user_id: @user.id)
      end
      it 'loads the show template' do
        get :show, id: @note.id
        expect(response).to render_template :show
      end
      it 'instantiates the variable @note' do
        get :show, id: @note.id
        expect(assigns(:note)).to eq(@note)
      end
    end

    context 'when user logged in but not note owner' do
      before do
        user = create(:user)
        @note = create(:note, user_id: user.id)
      end
      it 'raises an ActiveRecord::RecordNotFound error' do
        login
        expect do
          get :show, id: @note.id
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is not logged in' do
      before do
        user = create(:user)
        @note = create(:note, user_id: user.id)
      end
      it 'redirects to the new session path' do
        get :show, id: @note.id
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      def valid_request
        patch :update, id: @note.id, note: { title: 'This is an awesome note!' }
      end
      context 'when user is owner of the note' do
        before do
          login
          @note = create(:note, title: 'This is the title', user_id: @user.id)
        end
        it 'updates the note in the database' do
          valid_request
          expect(@note.reload.title).to eq 'This is an awesome note!'
        end
        it 'redirects to the notes path' do
          valid_request
          expect(response).to redirect_to note_path(@note)
        end
      end

      context 'when user logged in but not note owner' do
        before do
          user = create(:user)
          @note = create(:note, user_id: user.id, title: 'This is the title')
        end
        it 'raises an ActiveRecord::RecordNotFound error' do
          login
          expect do
            valid_request
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when user is not logged in' do
        before do
          @note = create(:note, title: 'This is the title')
        end
        it 'does not update the note in the database' do
          valid_request
          expect(@note.reload.title).to eq('This is the title')
        end
        it 'redirects to the new session path' do
          valid_request
          expect(response).to redirect_to new_session_path
        end
      end
    end

    context 'with invalid params' do
      def invalid_request
        patch :update, id: @note.id, note: { title: nil }
      end
      context 'when user is owner of the note' do
        before do
          login
          @note = create(:note, user_id: @user.id, title: 'Some random title')
        end
        it 'does not update the note in the databse' do
          invalid_request
          expect(@note.reload.title).to eq('Some random title')
        end
        it 'renders the edit template' do
          invalid_request
          expect(response).to render_template :edit
        end
      end

      context 'when user logged in but not note owner' do
        before do
          user = create(:user)
          @note = create(:note, user_id: user.id, title: 'Some random title')
        end
        it 'raises an ActiveRecord::RecordNotFound error' do
          login
          expect do
            invalid_request
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when user is not logged in' do
        before do
          @note = create(:note, title: 'This is the title')
        end
        it 'does not update the note in the database' do
          invalid_request
          expect(@note.reload.title).to eq('This is the title')
        end
        it 'redirects to the new session path' do
          invalid_request
          expect(response).to redirect_to new_session_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_request
      delete :destroy, id: @note.id
    end
    context 'when user is owner of the note' do
      before do
        login
        @note = create(:note, user_id: @user.id)
      end
      it 'removes the note from the database' do
        expect { delete_request }.to change { Note.count }.by(-1)
      end
      it 'redirects to the notes path' do
        delete_request
        expect(response).to redirect_to notes_path
      end
    end

    context 'when user logged in but not note owner' do
      before do
        user = create(:user)
        @note = create(:note, user_id: user.id, title: 'Some random title')
      end
      it 'raises an ActiveRecord::RecordNotFound error' do
        login
        expect do
          delete_request
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is not logged in' do
      before do
        @note = create(:note, title: 'This is the title')
      end
      it 'does not update the note in the database' do
        delete_request
        expect(@note.reload.title).to eq('This is the title')
      end
      it 'redirects to the new session path' do
        delete_request
        expect(response).to redirect_to new_session_path
      end
    end
  end

end
