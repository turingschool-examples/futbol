require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe GameStatistics do
    describe '#initialize' do
        it "exists" do 
            game_stats = GameStatistics.new([])
            expect(game_stats).to be_a GameStatistics
      end
    end
   
    describe '#highest_total_score' do
        it "returns the highest sum of the winning and losing teams scores" do
            game_data = Games.create_games_data_objects("./data/games_test.csv")
            game_stats = GameStatistics.new(game_data)           
            expect(game_stats.highest_total_score).to eq 5 # Calculated manually
        end
    end

    describe '#lowest_total_score' do
        it "returns the lowest sum of the winning and losing teams scores" do
            game_data = Games.create_games_data_objects("./data/games_test.csv")
            game_stats = GameStatistics.new(game_data)           
            expect(game_stats.lowest_total_score).to eq(1) # Calculated manually
        end
    end

    describe '#percentage_home_wins' do
        it "returns the percentage of home team wins" do
            game_data = Games.create_games_data_objects("./data/games_test.csv")
            game_stats = GameStatistics.new(game_data)
            total_games = game_stats.games.length
            home_wins = game_stats.games.count { |game| game.home_goals > game.away_goals }
            expect(game_stats.percentage_home_wins).to eq(60.00)
        end
    end

    describe '#percentage_visitor_wins' do
        it "returns the percentage of away team wins" do
            game_data = Games.create_games_data_objects("./data/games_test.csv")
            game_stats = GameStatistics.new(game_data)
            total_games = game_stats.games.length
            away_wins = game_stats.games.count { |game| game.away_goals > game.home_goals }
            expect(game_stats.percentage_visitor_wins).to eq(40.00)
        end   
    end


    describe '#percentage_ties' do
        it "returns the percentage of tie games" do
            game_data = Games.create_games_data_objects("./data/games_test.csv")
            game_stats = GameStatistics.new(game_data)
            total_games = game_stats.games.length
            tie_games = game_stats.games.count { |game| game.home_goals == game.away_goals }
            expect(game_stats.percentage_tie_games).to eq(0.00)
        end   
    end

    describe '#count_of_games_by_season' do
        it "returns a hash with season id's as keys and a count of games as values" do
            game_data = Games.create_games_data_objects("./data/games_test.csv")
            game_stats = GameStatistics.new(game_data) 
            expect(game_stats.count_of_games_by_season).to eq({ 20122013 => 10 })
        end
    end

    
end