require './lib/league_processor'
require './lib/game_team'
require './lib/game'

RSpec.describe LeagueProcessor do

  let(:dummy_class) { Class.new { extend LeagueProcessor } }
  let(:game_team_row1) { {game_id:"2012030221",
    team_id:"3",
    goals: "1",
    head_coach: "John Tortorella",
    result: "LOSS",
    shots: "8",
    tackles: "44"
  } }
  let(:game_team_row2) { {game_id:"2012030221",
    team_id:"6",
    goals: "3",
    head_coach: "Claude Julien",
    result: "WIN",
    shots: "12",
    tackles: "51"
  } }
  let(:game_row3) { {game_id: "2012030221",
    season: "20122013",
    away_team_id: "3",
    home_team_id: "6",
    away_goals: "2",
    home_goals: "3"
  }}
  let(:game_row4) { {game_id: "2012030221",
    season: "20122013",
    away_team_id: "6",
    home_team_id: "3",
    away_goals: "4",
    home_goals: "2"
  }}

  let(:game_teams) {[GameTeam.new(game_team_row1), GameTeam.new(game_team_row2)]}
  let(:games) {[Game.new(game_row3), Game.new(game_row4)]}

  it 'returns team id with best offense' do
    expect(dummy_class.offense("best", game_teams)).to eq(6)
  end

  it 'returns team id with worst offense' do
    expect(dummy_class.offense("worst", game_teams)).to eq(3)
  end

  it 'returns visitor team id with highest score' do
    expect(dummy_class.visitor_scoring_outcome("highest_scoring", games)).to eq(6)
  end

  it 'returns visitor team id with lowest score' do
    expect(dummy_class.visitor_scoring_outcome("lowest_scoring", games)).to eq(3)
  end

  it 'returns home team with highest score' do
    expect(dummy_class.home_scoring_outcome("highest_scoring", games)).to eq(6)
  end

  it 'returns home team with lowest score' do
    expect(dummy_class.home_scoring_outcome("lowest_scoring", games)).to eq(3)
  end

end
