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

  context 'games' do
    it 'has highest and lowest total scored' do
      expect(@general_manager.highest_total_score).to eq(7)
      expect(@general_manager.lowest_total_score).to eq(1)
    end

    it 'counts games per season' do
      expected = {
        '20132014' => 6,
        '20142015' => 19,
        '20152016' => 9,
        '20162017' => 17
      }
      expect(@general_manager.count_of_games_by_season).to eq(expected)
    end

    it 'has average goals by season' do
      expected = {
        "20142015"=>3.63,
        "20152016"=>4.33,
        "20132014"=>4.67,
        "20162017"=>4.24
      }
      expect(@general_manager.average_goals_by_season).to eq(expected)
    end

    it 'has average goals per game' do
      expect(@general_manager.average_goals_per_game).to eq(4.08)
    end

    it 'highest scoring vistor and home team' do
      expect(@general_manager.highest_scoring_visitor).to eq("5")
      expect(@general_manager.highest_scoring_home_team).to eq("24")
    end

    it 'lowest scoring vistor and home team' do
      expect(@general_manager.lowest_scoring_visitor).to eq("13")
      expect(@general_manager.lowest_scoring_home_team).to eq("13")
    end

    it 'has a favourite opponent' do
      expect(@general_manager.favorite_opponent("15")).to eq("2")
    end

    it 'has a rival' do
      expect(@general_manager.rival("15")).to eq("10")
    end
  end
end
