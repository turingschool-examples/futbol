require 'spec_helper'

RSpec.describe GeneralManager do
  before :all do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @general_manager = GeneralManager.new(locations)
  end

  context 'initialize' do
    it 'exists' do
      expect(@general_manager).to be_a(GeneralManager)
    end

    it 'has attributes' do
      expect(@general_manager.teams_manager).to be_a(TeamsManager)
      expect(@general_manager.games_manager).to be_a(GamesManager)
      expect(@general_manager.game_teams_manager).to be_a(GameTeamsManager)
    end
  end

  context 'teams' do
    it 'has team info' do
      expected = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      }

      expect(@general_manager.team_info("18")).to eq(expected)
    end

    it 'has a teams count in a league' do
      expect(@general_manager.count_of_teams).to eq(32)
    end

  end
end
