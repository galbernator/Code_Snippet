require 'rails_helper'

RSpec.describe 'admin/categories/edit', type: :view do
  it 'renders new category form' do
    @category = create(:category, title: 'Go')
    render
    assert_select 'form[action=?][method=?]', category_path(@category), 'post' do
      assert_select 'input#category_title[value=?]', @category.title
    end
  end
end
