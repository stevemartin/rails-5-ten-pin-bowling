require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
      :players => 1
    ))
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do

      assert_select "input#game_players[name=?]", "game[players]"
    end
  end
end
