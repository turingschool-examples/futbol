require 'spec_helper.rb'

RSpec.describe Game do
  it "can initialize" do
    game_team = GameTeam.new("3", "away", "LOSS", "John Tortorella", "2", "8", "44")

    expect(game_team.team_id).to eq "3"
    expect(game_team.home_or_away).to eq "away"
    expect(game_team.result).to eq "LOSS"
    expect(game_team.head_coach).to eq "John Tortorella"
    expect(game_team.goals).to eq "2"
    expect(game_team.shots).to eq "8"
    expect(game_team.tackles).to eq "44"
  end
end
