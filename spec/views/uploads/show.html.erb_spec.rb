require 'rails_helper'

RSpec.describe "uploads/show", type: :view do
  before(:each) do
    @upload = assign(:upload, Upload.create!(
      :name => "Name",
      :link => "Link",
      :reference => "Reference",
      :archived => false,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Reference/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
