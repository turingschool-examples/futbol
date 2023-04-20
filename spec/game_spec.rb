require "./spec_helper"

RSpec. describe Game do
  describe "it makes a Game" do
    games = Game.new()
    expect(games).to be_a(Game)
  end
end