require 'spec_helper'

RSpec.describe GamesStats do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
    games: @game_path,
    teams: @team_path,
    game_teams: @game_teams_path
    }

    @games_stats = GamesStats.new(@locations)
    @games_stats.merge_game_game_teams
    @games_stats.merge_teams_to_game_game_teams
  end

  describe '#initialize' do
    xit 'exists' do
      expect(@games_stats).to be_a(GamesStats)
    end
  end

  # highest sum of winning and losing teams score
  describe '#highest_total_score' do
    xit 'checks highest total score of a game' do
    expect(@games_stats.highest_total_score).to eq(11)
    end
  end

  describe '#lowest_total_score' do
    xit 'checks lowest total score of a game' do
      expect(@games_stats.lowest_total_score).to eq(0)
    end
  end

  describe '#percentage_home_wins' do 
    xit 'Percentage of games that all home teams have won (rounded to the nearest 100th)' do 
      expect(@games_stats.percentage_home_wins).to eq(0.44)
    end
  end

  describe '#percentage_visitor_wins' do 
    xit 'Percentage of games that a visitor has won (rounded to the nearest 100th)'do 
    expect(@games_stats.percentage_visitor_wins).to eq(0.36)
    end
  end
  
  describe '#percentage_ties' do 
    xit 'Percentage of games that has resulted in a tie (rounded to the nearest 100th)'do 
    expect(@games_stats.percentage_ties).to eq(0.20)
    end
  end
    
end