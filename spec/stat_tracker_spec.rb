require 'spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
  describe '#initialize' do
    it 'exists with attributes' do
      game_path = './data/games_test.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      
      stat_tracker = StatTracker.new(locations)
      
      expect(stat_tracker).to be_a StatTracker
      expect(stat_tracker.games).to be_all Games
      expect(stat_tracker.teams).to be_all Teams
      expect(stat_tracker.game_teams).to be_all GameTeams
      expect(stat_tracker.games.first).to be_a Games
      expect(stat_tracker.teams.first).to be_a Teams
      expect(stat_tracker.game_teams.first).to be_a GameTeams
      expect(stat_tracker.games.first.game_id).to eq(2012030221)
      expect(stat_tracker.teams.first.team_id).to eq(1)
      expect(stat_tracker.game_teams.first.game_id).to eq(2012030221)
    end
  end


  describe '#initialize' do
    it "exists" do 
      stat_tracker = StatTracker.new([], [], [])
      expect(stat_tracker).to be_a StatTracker
    end
  end

  #League Stats Spec

  # before(:each) do
  #   teams_data = Teams.create_teams_data_objects("./data/teams.csv")
  #   game_teams_data = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
  #   stat_tracker = StatTracker.new(game_teams, game_data, teams)
  # end

  describe 'count_of_teams' do
    it "counts all of the teams in the league" do
      teams = Teams.create_teams_data_objects("./data/teams.csv")

      expect(teams.count).to be 32
      expect(teams).to be_all Teams
    end
  end

  describe "total goals ever" do
    it "calculates the total number of goals a team has scored across all seasons" do
      team = Teams.new(6,6,"FC Dallas","DAL","Toyota Stadium","/api/v1/teams/6")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      
      expect(team.total_goals_ever).to be 24
    end
  end

  describe "average goals" do
    xit "calculates a team's average number of goals per game across all seasons" do
      expect(team.average_goals).to be 2.67
    end
  end

  describe 'best_offense' do
    xit "determines the name of the team with the highest average number of goals per game" do
      
      expect(game_team_stats.best_offense).to be_a(string)
    end
  end

  describe 'worst_offense' do
    xit "determines the name of the team with the lowest average number of goals per game" do
      
    end
  end

#   describe 'highest_scoring_visitor' do
#     xit "determines the name of the team with the most average goals per away game" do
    
#     end   
#   end


#   describe 'highest_scoring_home_team' do
#     xit "determines the name of the team with the most average goals per home game" do
    
#     end   
#   end

#   describe 'lowest_scoring_visitor' do
#     xit "determines the name of the team with the least average goals per away game" do
    
#     end
#   end

#   describe 'lowest_scoring_home_team' do
#     xit "determines the name of the team with the least average goals per home game" do
      
#     end
#   end 

end