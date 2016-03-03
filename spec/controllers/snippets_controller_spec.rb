require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do

  let(:snippet) { create(:snippet) }
  let(:user) { create(:user) }

  def login
    request.session[:user_id] = user.id
  end

  describe 'Snippet' do
    it 'is a valid snippet' do
      expect(build(:snippet)).to be_valid
    end
  end

  describe 'GET #index' do
    it 'returns HTTP success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
    it 'assigns instance variable @snippets' do
      snippet_1 = snippet
      get :index
      expect(assigns(:snippets)).to eq([snippet_1])
    end
  end

  describe 'GET #new' do
    it 'gets the new template' do
      get :new
      expect(response).to render_template :new
    end
    it 'creates a new instance variable @snippet' do
      get :new
      expect(assigns(:snippet)).to be_a_new Snippet
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      def valid_request
        post :create, snippet: attributes_for(:snippet)
      end
      it 'adds a new snippet to the database' do
        expect { valid_request }.to change { Snippet.count }.by(1)
      end
      it 'redirects to the snippet path' do
        valid_request
        expect(response).to redirect_to snippet_path(Snippet.last.id)
      end
    end

    context 'with invalid params' do
      def invalid_request
        post :create, snippet: attributes_for(:snippet, block: nil)
      end
      it 'does not add a snippet to the database' do
        expect { invalid_request }.to_not change { Snippet.count }
      end
      it 'renders the new template' do
        invalid_request
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before do
      @snippet = snippet
    end
    it 'renders the show template' do
      get :show, id: @snippet.id
      expect(response).to render_template :show
    end
    it 'instantiates variable @snippet' do
      get :show, id: @snippet.id
      expect(assigns(:snippet)).to eq(@snippet)
    end
  end

  describe 'GET #edit' do
    before do
      login
      @snippet = snippet
    end
    it 'renders the edit template' do
      get :edit, id: @snippet.id
      expect(response).to render_template :edit
    end
    it 'instantiates variable @snippet' do
      get :edit, id: @snippet.id
      expect(assigns(:snippet)).to eq(@snippet)
    end
  end

  describe 'GET #update' do
    before do
      @snippet = snippet
    end
    context 'with user logged in' do
      before do
        login
      end
      context 'with valid params' do
        def valid_request
          patch :update, id: @snippet.id, snippet: { title: 'Sweet Snip' }
        end
        it 'updates the snippet in the database' do
          valid_request
          expect(@snippet.reload.title).to eq('Sweet Snip')
        end
        it 'redirects to the snippet path' do
          valid_request
          expect(response).to redirect_to snippet_path(@snippet)
        end
      end

      context 'with invalid params' do
        def invalid_request
          patch :update, id: @snippet.id, snippet: { block: nil }
        end
        it 'does not update the snippet' do
          invalid_request
          expect(@snippet.reload.block).to_not eq(nil)
        end
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the new session path' do
        patch :update, id: @snippet.id, snippet: { block: 'update things' }
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'GET #delete' do
    before do
      login
      @snippet = snippet
    end
    context ''
    def delete_request
      delete :destroy, id: @snippet.id
    end
    it 'deletes the snippet from the database' do
      expect { delete_request }.to change { Snippet.count }.by(-1)
    end
    it 'redirects to the snippet index page' do
      delete_request
      expect(response).to redirect_to snippets_path
    end

  end

end
