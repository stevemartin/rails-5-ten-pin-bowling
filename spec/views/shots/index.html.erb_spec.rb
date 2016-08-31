require 'rails_helper'

RSpec.describe "shots/index", type: :view do
  before(:each) do
    assign(:shots, [
      Shot.create!(
        :game => nil,
        :number => 2,
        :frame => 3,
        :player => 4,
        :pins => 5
      ),
      Shot.create!(
        :game => nil,
        :number => 2,
        :frame => 3,
        :player => 4,
        :pins => 5
      )
    ])
  end

  it "renders a list of shots" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
