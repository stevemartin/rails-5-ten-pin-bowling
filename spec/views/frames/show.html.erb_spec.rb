require 'rails_helper'

RSpec.describe "frames/show", type: :view do
  before(:each) do
    @frame = assign(:frame, Frame.create!(
      :game => nil,
      :player_number => 2,
      :frame_number => 3,
      :total => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
