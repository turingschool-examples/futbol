require './spec/spec_helper'

RSpec.describe AllSeasonData do
  game_path = './data/games_fixture.csv'
  team_path = './data/teams_fixture.csv'
  game_teams_path = './data/game_teams_fixture.csv'
  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
  
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  let(:all_season_data) { stat_tracker.all_season_data }

  describe '#initialize' do
    it 'can initialize' do
      expect(all_season_data).to be_a(AllSeasonData)
    end
  end

  
end