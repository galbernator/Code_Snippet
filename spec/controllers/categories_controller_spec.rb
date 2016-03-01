require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  def login
    user = create(:user, role: 'admin', password: 'Things!')
    request.session[:user_id] = user.id
  end

  def create_category(options = nil)
    @category = create(:category, options)
  end

  describe 'Category' do
    it 'is a valid user' do
      expect(build(:category)).to be_valid
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
    it 'set an instance variable @categories' do
      create_category
      get :index
      expect(assigns(:categories)).to eq([@category])
    end
  end

  describe 'GET #show' do
    before do
      create_category
      get :show, id: @category.id
    end
    it 'renders the show template' do
      expect(response).to render_template :show
    end
    it 'instantiates a variable with the passed id' do
      expect(assigns(:category)).to eq(@category)
    end
  end

  describe 'GET #search' do
    it 'renders the search template' do
      create_category({ title: 'Ruby'})
      post :search, id: @category.id, search: 'ruby'
      expect(response).to render_template :search
    end
    it 'assigns instance variable @search to the search term' do
      create_category({ title: 'Ruby'})
      post :search, id: @category.id,  search: 'ruby'
      expect(assigns(:search)).to eq('ruby')
    end
    it 'returns results of search in an snippets instance variable' do
      category_1 = create_category({ title: 'PHP' })
      category_2 = create_category({ title: 'Ruby' })
      snippet = create(:snippet, description: 'this has Ruby things')
      category_2.snippets << snippet
      post :search, id: category_2.id, search: 'ruby'
      expect(assigns(:snippets)).to eq([snippet])
    end
  end
end
