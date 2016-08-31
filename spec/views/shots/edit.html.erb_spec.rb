require 'rails_helper'

RSpec.describe "shots/edit", type: :view do
  before(:each) do
    @game = Game.create(players: 2)
    @shot = assign(:shot, Shot.create!(
      :game => @game,
      :number => 1,
      :frame => 1,
      :player => 1,
      :pins => 1
    ))
  end

  it "renders the edit shot form" do
    render

    assert_select "form[action=?][method=?]", shot_path(@shot), "post" do

      assert_select "input#shot_game_id[name=?]", "shot[game_id]"

      assert_select "input#shot_number[name=?]", "shot[number]"

      assert_select "input#shot_frame[name=?]", "shot[frame]"

      assert_select "input#shot_player[name=?]", "shot[player]"

      assert_select "input#shot_pins[name=?]", "shot[pins]"
    end
  end
end
