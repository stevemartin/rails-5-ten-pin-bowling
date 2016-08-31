require 'rails_helper'

RSpec.describe "frames/index", type: :view do
  before(:each) do
    assign(:frames, [
      Frame.create!(
        :game => nil,
        :player_number => 2,
        :frame_number => 3,
        :total => 4
      ),
      Frame.create!(
        :game => nil,
        :player_number => 2,
        :frame_number => 3,
        :total => 4
      )
    ])
  end

  it "renders a list of frames" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
