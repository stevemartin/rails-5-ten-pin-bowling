require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    session[:frame] = 1
    @game = assign(:game, Game.create!(
      :players => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
  end
end
