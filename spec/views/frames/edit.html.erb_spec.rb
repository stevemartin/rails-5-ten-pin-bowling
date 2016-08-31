require 'rails_helper'

RSpec.describe "frames/edit", type: :view do
  before(:each) do
    @frame = assign(:frame, Frame.create!(
      :game => nil,
      :player_number => 1,
      :frame_number => 1,
      :total => 1
    ))
  end

  it "renders the edit frame form" do
    render

    assert_select "form[action=?][method=?]", frame_path(@frame), "post" do

      assert_select "input#frame_game_id[name=?]", "frame[game_id]"

      assert_select "input#frame_player_number[name=?]", "frame[player_number]"

      assert_select "input#frame_frame_number[name=?]", "frame[frame_number]"

      assert_select "input#frame_total[name=?]", "frame[total]"
    end
  end
end