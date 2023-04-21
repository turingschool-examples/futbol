require './spec/spec_helper'

RSpec.describe StatTracker do 
  before(:each) do 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
    @test_games = @stat_tracker.games[0..100]
  end
  
  describe '#initialize' do 
    xit 'exists' do 
      expect(@stat_tracker).to be_a(StatTracker)
    end

    xit 'has an array of games' do 
      expect(@stat_tracker.games).to be_a Array
      expect(@stat_tracker.games[0]).to be_a Game
    end
    
    xit 'has an array of gameteams' do    
      expect(@stat_tracker.game_teams).to be_a Array
      expect(@stat_tracker.game_teams[0]).to be_a GameTeam
    end
    xit 'has an array of teams' do 
      expect(@stat_tracker.teams).to be_a Array
      expect(@stat_tracker.teams[0]).to be_a Team
    end
  end

#game class
  describe 'game averages' do 
    xit '#average_goals_per_game' do 
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end

    it '#average_goals_by_season' do 
      expect(@stat_tracker.average_goals_by_season).to eq({
          "20122013"=>4.12,
          "20162017"=>4.23,
          "20142015"=>4.14,
          "20152016"=>4.16,
          "20132014"=>4.19,
          "20172018"=>4.44
      })
    end

    xit 'can collect the sum of highest winning scores' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    xit 'can collect the sum of lowest winning scores' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end

  describe 'percentage of wins' do 
    xit 'can calculate the percentage of home wins' do 
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end 

    xit 'can calculate the percentage of visitor wins' do 
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe '#percentage_ties method' do
    xit 'shows the percentage of ties per season' do 
      expect(@stat_tracker.percentage_ties).to eq(0.2)
    end
  end

  describe '#count_of_games_by_season method' do
    xit 'counts number of games played per season' do
      hash = {"20122013"=>806, "20132014"=>1323, "20142015"=>1319, "20152016"=>1321, "20162017"=>1317, "20172018"=>1355}
      expect(@stat_tracker.count_of_games_by_season).to eq(hash)
    end
  end

#game_teams/league stats

  describe 'count of teams' do 
    xit 'can count the total number of teams in the data' do 
      expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe 'best offense' do 
    xit 'can return team with highest average goals per game' do 
      expect(@stat_tracker.best_offense).to eq('Reign FC')
    end
  end

  describe 'worst offense' do 
    xit 'can return team with lowest average goals per game' do 
      expect(@stat_tracker.worst_offense).to eq('Utah Royals FC')
    end
  end

  describe 'highest scoring avg' do 
    xit 'can return name of team with highest avg score per game when they are away' do 
      expect(@stat_tracker.highest_scoring_visitor).to eq('FC Dallas')
    end
  
    xit 'can return name of team with highest avg score per game when they are home' do 
      expect(@stat_tracker.highest_scoring_home_team).to eq('Reign FC')
    end
  end

  describe 'lowest scoring avg' do 
    xit 'can return name of team with lowest score per game when they are away' do 
      expect(@stat_tracker.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end

    xit 'can return name of team with lowest score per game when they are home' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end

  describe 'helpers' do 
    it '#total_goals' do 
      expect(@stat_tracker.total_goals(@test_games)).to eq(397)
    end
  end
end