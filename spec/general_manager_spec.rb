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
      expect(@general_manager.highest_scoring_visitor).to eq("Sporting Kansas City")
      expect(@general_manager.highest_scoring_home_team).to eq("Real Salt Lake")
    end

    it 'lowest scoring vistor and home team' do
      expect(@general_manager.lowest_scoring_visitor).to eq("Houston Dash")
      expect(@general_manager.lowest_scoring_home_team).to eq("Houston Dash")
    end

    it 'has a favourite opponent' do
      expect(@general_manager.favorite_opponent("15")).to eq("North Carolina Courage")
    end

    it 'has a rival' do
      expect(@general_manager.rival("15")).to eq("Seattle Sounders FC")
    end
  end

  context 'game teams' do
    it 'has winningest coach' do
      expect(@general_manager.winningest_coach("20142015")).to eq('Alain Vigneault')
    end

    it 'has worst coach' do
      expect(@general_manager.worst_coach("20142015")).to eq("Mike Johnston")
    end

    it "has most accurate and least accurate teams" do
      expect(@general_manager.most_accurate_team("20132014")).to eq("New England Revolution")
      expect(@general_manager.least_accurate_team("20132014")).to eq("Philadelphia Union")
    end

    it 'names the team with the most and fewest tackles' do
      expect(@general_manager.most_tackles("20142015")).to eq("Houston Dynamo")
      expect(@general_manager.fewest_tackles("20142015")).to eq("DC United")
    end

    it 'has best and worst seasons' do
      expect(@general_manager.best_season("3")).to eq("20142015")
      expect(@general_manager.worst_season("15")).to eq("20152016")
    end

    it 'has an average win percentage' do
      expect(@general_manager.average_win_percentage("15")).to eq(0.67)
    end

    it "can get most and fewest number of goals" do
      expect(@general_manager.most_goals_scored("3")).to eq(5)
      expect(@general_manager.fewest_goals_scored("3")).to eq(0)
    end

    it 'has best offense' do
      expect(@general_manager.best_offense).to eq("Los Angeles FC")
    end

    it 'has worst offense' do
      expect(@general_manager.worst_offense).to eq("Chicago Fire")
    end

    it "percentage of home wins, away wins" do
      expect(@general_manager.percentage_home_wins).to eq(0.43)
      expect(@general_manager.percentage_visitor_wins).to eq(0.59)
    end

    it "has percentage ties" do
      expect(@general_manager.percentage_ties).to eq(0.0)
    end
  end
end
