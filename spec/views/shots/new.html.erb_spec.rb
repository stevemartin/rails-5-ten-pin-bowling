require 'rails_helper'

RSpec.describe "shots/new", type: :view do
  before(:each) do
    assign(:shot, Shot.new(
      :game => nil,
      :number => 1,
      :frame => 1,
      :player => 1,
      :pins => 1
    ))
  end

  it "renders new shot form" do
    render

    assert_select "form[action=?][method=?]", shots_path, "post" do

      assert_select "input#shot_game_id[name=?]", "shot[game_id]"

      assert_select "input#shot_number[name=?]", "shot[number]"

      assert_select "input#shot_frame[name=?]", "shot[frame]"

      assert_select "input#shot_player[name=?]", "shot[player]"

      assert_select "input#shot_pins[name=?]", "shot[pins]"
    end
  end
end
