require 'spec_helper'

describe Game do
 data = {
    "game_id" => "100201",
    "season" => "101102",
    "type" => "Postseason",
    "date_time" => "10/17/2022",
    "away_team_id" => "6",
    "home_team_id" => "20",
    "away_goals" => "199",
    "home_goals" => "1",
    "venue" => "Gibraltar",
    "venue_link" => "rockOf"
  }
  

game = Game.new(data)

  it 'exists' do
     expect(game.id).to eq(100201)
     expect(game.season).to eq("101102")
     expect(game.type).to eq("Postseason")
     expect(game.date_time).to eq("10/17/2022")
  end
end
