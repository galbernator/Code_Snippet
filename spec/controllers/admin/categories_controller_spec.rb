require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Admin::CategoriesController, type: :controller do

  describe "GET #index" do
    context 'when user is logged in and is admin' do

      before do
        user = FactoryGirl.create(:user, role: 'admin', password: 'Things!')
        request.session[:user_id] = user.id
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


  describe "GET #new" do
    context 'when user is logged in and is admin' do

      before do
        user = FactoryGirl.create(:user, role: 'admin', password: 'Things!')
        request.session[:user_id] = user.id
      end

      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates a new Category variable" do
        get :new
        expect(assigns(:category)).to be_a_new Category
      end
    end

    context 'when the user is not logged in or not admin' do
      it 'has 302 HTTP status' do
        get :new
        expect(response).to have_http_status 302
      end

      it 'redirects to root path' do
        get :new
        expect(response).to redirect_to root_path
      end

      it 'sets flash notice' do
        get :new
        expect(flash[:notice]).to be
      end

    end
  end

  describe 'POST #create' do
    context 'when user is logged in and is admin' do
      before do
        user = FactoryGirl.create(:user, role: 'admin', )
      end
    end

      context 'when the user is not logged in or not admin' do

      end
  end

end
