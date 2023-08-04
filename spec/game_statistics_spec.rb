require "spec_helper"

RSpec.describe GameStatistics do
  before :each do
    @game_path = './fixture/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixture/game_teams_fixture.csv'
    
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @game_stats = GameStatistics.new(@locations)
  end

  describe "#initialize" do
    it 'exists' do
      expect(@game_stats).to be_a GameStatistics
    end
  end

    describe "#locations" do
    it "returns the location attribute" do
      expect(@game_stats.locations).to eq(@locations)
    end
  end

  describe "#game_data" do
    it "returns game_data" do
      expect(@game_stats.game_data).to be_a(CSV::Table)
    end
  end

  describe "#teams_data" do
    it "returns teams_data" do
      expect(@game_stats.teams_data).to be_a(CSV::Table)
    end
  end

  describe "#game_team_data" do
    it "returns game_team_data" do
      expect(@game_stats.game_team_data).to be_a(CSV::Table)
    end
  end

  describe "#highest_total_score" do
    it "finds the highest total score from stat data" do
      expect(@game_stats.highest_total_score).to eq(5)
    end
  end

  describe "lowest_total_score" do
    it "finds the lowest total score from stat data" do
      expect(@game_stats.lowest_total_score).to eq(1)
    end
  end

  describe "#percentage_home_wins" do
    it "finds percentage of games that a home team has won(rounded to nearedst 100th)" do
      expect(@game_stats.percentage_home_wins).to eq(0.68)
    end
  end

  describe "#percentage_visitor_wins" do
    it "finds percentage of games that a visitor team has won(rounded to nearedst 100th)" do
      expect(@game_stats.percentage_visitor_wins).to eq(0.26)
    end
  end

  describe "#percent ties" do
    it "finds percntage of tied away and home games" do
      expect(@game_stats.percentage_ties).to eq(0.05)
    end
  end

  describe "#percentage_calculator" do
    it "finds the percentage for given numbers rounded to nearest 100th" do
      expect(@game_stats.percentage_calculator(13.0, 19.0)).to eq(0.68)
      expect(@game_stats.percentage_calculator(5.0, 19.0)).to eq(0.26)
      expect(@game_stats.percentage_calculator(1.0, 19.0)).to eq(0.05)
    end
  end

  describe "#count_of_games_by_season_do" do
    it "returns a hash with season names as keys and count of games as values" do
      expect(@game_stats.count_of_games_by_season).to eq({ "20122013" => 19 })
    end
  end

  describe "#average_goals_per_game" do
    it "returns average number of goals scored in a game across all seasons including both home and away goals" do
      expect(@game_stats.average_goals_per_game).to eq(3.68)
    end
  end

  describe "#average_goals_by_season" do
    it "returns average number of goals scored in a game in that season" do
      expect(@game_stats.average_goals_by_season).to eq({ "20122013" => 3.68 })
    end
  end
end