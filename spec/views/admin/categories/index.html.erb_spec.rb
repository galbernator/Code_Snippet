require 'rails_helper'

RSpec.describe "admin/categories/index", type: :view do
  before(:each) do
    assign(:categories, [create(:category, title: 'Ruby'), create(:category, title: 'Ruby on Rails')])
  end

  it "renders a list of categories" do
    render
    assert_select "tr>td", :text => "Ruby".to_s, :count => 1
    assert_select "tr>td", :text => "Ruby on Rails".to_s, :count => 1
  end
end
