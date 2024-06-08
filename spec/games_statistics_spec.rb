require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
  describe '#initialize' do
    it "exists" do 
      stat_tracker = StatTracker.new([], [], [])
      expect(stat_tracker).to be_a StatTracker
    end
  end
  
  describe '#highest_total_score' do
    it "returns the highest sum of the winning and losing teams scores" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams)           
      expect(stat_tracker.highest_total_score).to eq 5 # Calculated manually
    end
  end

  describe '#lowest_total_score' do
    it "returns the lowest sum of the winning and losing teams scores" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      expect(stat_tracker.lowest_total_score).to eq(1) # Calculated manually
    end
  end

  describe '#percentage_home_wins' do
    it "returns the percentage of home team wins" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      total_games = stat_tracker.games.length
      home_wins = stat_tracker.games.count { |game| game.home_goals > game.away_goals }
      expect(stat_tracker.percentage_home_wins).to eq(60.00)
    end
  end

  describe '#percentage_visitor_wins' do
    it "returns the percentage of away team wins" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      total_games = stat_tracker.games.length
      away_wins = stat_tracker.games.count { |game| game.away_goals > game.home_goals }
      expect(stat_tracker.percentage_visitor_wins).to eq(40.00)
    end   
  end


  describe '#percentage_ties' do
    it "returns the percentage of tie games" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      total_games = stat_tracker.games.length
      tie_games = stat_tracker.games.count { |game| game.home_goals == game.away_goals }
      expect(stat_tracker.percentage_tie_games).to eq(0.00)
    end   
  end

  describe '#count_of_games_by_season' do
    it "returns a hash with season id's as keys and a count of games as values" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      expect(stat_tracker.count_of_games_by_season).to eq({ 20122013 => 10 })
    end
  end

  describe '#average_goals_per_game' do
    it "returns average number of goals scored per game from all seasons" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      total_goals = game_data.sum { |game| game.home_goals + game.away_goals }
      total_games = game_data.length
      expect(stat_tracker.average_goals_per_game).to eq(3.70)
    end
  end 

  describe '#average_goals_by_season' do
    it "returns a hash with season id's as keys and a float of average number of goals per game as value" do
      game_data = Games.create_games_data_objects("./data/games_test.csv")
      game_teams = GameTeams.create_game_teams_data_objects("./data/test_game_teams.csv")
      teams = Teams.create_teams_data_objects("./data/teams.csv")
      stat_tracker = StatTracker.new(game_teams, game_data, teams) 
      expect(stat_tracker.average_goals_by_season).to eq({ 20122013 => 3.70 })
    end
  end
end