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
    @game = Game.new(@stat_tracker.games_data, @stat_tracker.game_team_data)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_a Game
    end
  end
end
