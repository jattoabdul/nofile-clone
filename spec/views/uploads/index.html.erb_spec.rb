require 'rails_helper'

RSpec.describe "uploads/index", type: :view do
  before(:each) do
    assign(:uploads, [
      Upload.create!(
        :name => "Name",
        :link => "Link",
        :reference => "Reference",
        :archived => false,
        :user => nil
      ),
      Upload.create!(
        :name => "Name",
        :link => "Link",
        :reference => "Reference",
        :archived => false,
        :user => nil
      )
    ])
  end

  it "renders a list of uploads" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Reference".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
