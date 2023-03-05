require_relative './spec_helper'

describe Game do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @test_game = @stat_tracker.games[0]
  end

  describe '#initialize' do
    it 'exists' do
      expect(@test_game).to be_a Game
    end

    it 'has attributes' do
      expect(@test_game.game_id).to eq("2012030221")
      expect(@test_game.season).to eq("20122013")
      expect(@test_game.type).to eq('Postseason')
      expect(@test_game.date_time).to eq("5/16/13")
      expect(@test_game.away_team_id).to eq("3")
      expect(@test_game.home_team_id).to eq("6")
      expect(@test_game.away_goals).to eq(2)
      expect(@test_game.home_goals).to eq(3)
      expect(@test_game.venue).to eq("Toyota Stadium")
      expect(@test_game.away_team_name).to eq('Houston Dynamo')
      expect(@test_game.home_team_name).to eq('FC Dallas')
    end
  end
end
