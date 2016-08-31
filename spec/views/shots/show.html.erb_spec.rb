require 'rails_helper'

RSpec.describe "shots/show", type: :view do
  before(:each) do
    @shot = assign(:shot, Shot.create!(
      :game => nil,
      :number => 2,
      :frame => 3,
      :player => 4,
      :pins => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
