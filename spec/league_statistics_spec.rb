require "spec_helper"

RSpec.describe LeagueStatistics do
  before :each do 
    @game_path = './fixture/games_fixture.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixture/game_teams_fixture.csv'
    
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @league_stats = LeagueStatistics.new(@locations)
  end

  describe "#initialize" do
    it 'exists' do
      expect(@league_stats).to be_a LeagueStatistics
    end
  end

  describe "#count_of_teams" do
    it "can show total number of teams" do 
      expect(@league_stats.count_of_teams).to eq(32)
    end
  end

  describe "#team_name_by_id" do
    it "can show the name of a team based on an id" do 
      expect(@league_stats.team_name_by_id(6)).to eq("FC Dallas")
    end
  end

  describe "#best_offense" do
    it "can show the name of the team with the highest average number of goals scored per game across all seasons " do 
      expect(@league_stats.best_offense).to eq("FC Dallas")
    end
  end
end