require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  def login
    user = FactoryGirl.create(:user, role: 'admin', password: 'Things!')
    request.session[:user_id] = user.id
  end

  def create_category
    @category = FactoryGirl.create(:category)
  end

  describe 'Category' do
    it 'is a valid category' do
      expect(build(:category)).to be_valid
    end
  end

  describe "GET #index" do
    context 'when user is logged in and is admin' do
      before do
        login
      end
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'when the user is not logged in or not admin' do
      it 'has 302 HTTP status' do
        get :index
        expect(response).to have_http_status 302
      end
      it 'redirects to root path' do
        get :index
        expect(response).to redirect_to root_path
      end
      it 'sets flash notice' do
        get :index
        expect(flash[:notice]).to be
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is logged in as admin' do
      before do
        login
        create_category
      end
      it "returns http success" do
        get :edit, id: @category.id
        expect(response).to have_http_status(:success)
      end
      it 'renders the edit template' do
        get :edit, id: @category.id
        expect(response).to render_template :edit
      end
      it "assigns the instance variable @category" do
        get :edit, id: @category.id
        expect(assigns(:category)).to be_a Category
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is logged in as admin' do
      before do
        login
        @category = FactoryGirl.create(:category, title: 'PHP')
      end
      def valid_request
        patch :update, id: @category.id, category: { title: 'Ruby' }
      end
      context 'with valid params' do
        it 'updates the record' do
          valid_request
          expect(@category.reload.title).to eq('Ruby')
        end
        it 'redirects to the categories index page' do
          valid_request
          expect(response).to redirect_to admin_categories_path
        end
      end

      context 'with invalid params' do
        it 'renders the edit template' do
          patch :update, id: @category.id, category: { title: nil }
          expect(response).to render_template :edit
        end
      end
    end

    context 'when user is not logged in or logged in but not admin' do
      before do
        @category = FactoryGirl.create(:category, title: 'PHP')
      end
      it 'redirects to the root path' do
        patch :update, id: @category.id, category: { title: 'Ruby' }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_request
      delete :destroy, id: @category.id
    end
    context 'when user is logged in as admin' do
      before do
        login
        create_category
      end
      it 'deletes the record' do
        delete_request
        expect(Category.find_by_id(@category.id)).to_not be
      end
    end

    context 'when user is not logged in or logged in but not admin' do
      before do
        create_category
      end
      it 'does not delete the record' do
        expect { delete_request }.to_not change { Category.count }
      end
      it 'redirects to the root path' do
        delete_request
        expect(response).to redirect_to root_path
      end
    end
  end

end
