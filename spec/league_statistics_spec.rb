require 'spec_helper.rb'

RSpec.configure do |config|
  config.formatter = :documentation
end

describe LeagueStatistics do
  
  describe "class methods" do
    it "can count the total number of teams" do
      path = "./data/teams.csv"
      teams = Teams.create_teams_data_objects(path)

      expect(teams.count).to be 32
      expect(teams).to be_all Teams
    end

    xit "can count the total number of goals a team has scored" do
      path = "./data/test_game_teams.csv"
      game_teams = GameTeams.create_game_teams_data_objects(path)

      
    end

    xit "can determine a team's average number of goals per game" do
      path = "./data/test_game_teams.csv"
      game_teams = GameTeams.create_game_teams_data_objects(path)
      team = Teams.new(1, 23, "Atlanta United", "ATL", "Mercedes-Benz Stadium", "/api/v1/teams/1")
      #Insert test logic
      expect(game_teams.team.average_goals).to eq()
    end
    
    xit "can determine which team has had the best offense" do
      path = "./data/test_game_teams.csv"
      game_teams = GameTeams.create_game_teams_data_objects(path)
      #Insert test logic
      
    end
    
    xit "can determine which team has had the worst offense" do
      path = "./data/test_game_teams.csv"
      game_teams = GameTeams.create_game_teams_data_objects(path)
      #Insert test logic
      
    end

  end
end