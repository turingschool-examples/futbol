require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    ## LOCATING CSV FILES
    game_team_path = './data/game_team_fixture.csv'
    games_path = './data/games_fixture.csv'
    teams_path = './data/teams.csv'
    @locations = {  game_teams: game_team_path, 
                    games: games_path, 
                    teams: teams_path,
                  }

    @stats = StatTracker.from_csv(@locations)
    @stats.compile
  end
  
  describe '#initialize' do
    it 'exists' do
      expect(@stats).to be_instance_of(StatTracker)
    end
    
    it 'has attributes' do
      expect(@stats.all_data.values.all? { |file| File.exist?(file) } ).to be true
      # expect(@games).to eq([])
      # expect(@game_teams).to eq([])
      # expect(@teams).to eq([])
      # expect(@team_ids).to eq([])
    end
  end
  
  describe '::from_csv' do
    it 'Gets data and makes instance' do
      expect(StatTracker.from_csv(@locations)).to be_instance_of(StatTracker)
    end
  end
  
  describe '#GameStatistics' do
    it 'gets highest total score' do
      expect(@stats.highest_total_score).to eq(7)
    end

    it 'gets the lowest total score' do
      expect(@stats.lowest_total_score).to eq(1)
    end

    it 'returns a hash of season names as keys and counts of games as values' do
      expect(@stats.count_of_games_by_season).to eq({"20122013"=>18, "20152016"=>32, "20162017"=>35, "20172018"=>34})
      expect(@stats.count_of_games_by_season.class).to be Hash
    end

    it 'returns percentage of games home team won' do
      expect(@stats.percentage_home_wins).to be_a Float      
    end
     
    it 'returns percentage of games visitor team won' do
      expect(@stats.percentage_visitor_wins).to be_a Float
    end
    
    it 'returns percentage of games resulting in a tie' do
      expect(@stats.percentage_ties).to be_a Float
    end

    it 'rounds to 100 percent' do
      expect((@stats.percentage_ties + @stats.percentage_home_wins + @stats.percentage_visitor_wins).round).to eq(100.00)
    end

    it 'returns average number of goals scored in a game across all seasons' do
      expect(@stats.average_goals_per_game).to eq(3.91)
      expect(@stats.average_goals_per_game.class).to be Float
    end

    it 'returns average number of goals scored in a game' do
      expect(@stats.average_goals_by_season).to eq({"20122013"=>3.61, "20152016"=>4.28, "20162017"=>4.57, "20172018"=>4.38})
      expect(@stats.average_goals_by_season.class).to be Hash
    end

  end

  describe '#count_of_teams' do
    it 'gets total  number of teams in league' do
      expect(@stats.count_of_teams).to eq(32)
    end
  end

  describe '#best_offense, #worst_offense' do
    it 'gets number games each team played in a season' do
      expect(@stats.team_games_season_total.class).to be Hash
      expect(@stats.team_games_season_total['3']).to eq(6)
    end

    it 'gets number games each team played in a season' do
      expect(@stats.team_goals_season_total.class).to be Hash
      expect(@stats.team_goals_season_total['3']).to eq(9)
    end

    it 'team goal average per game in a season' do
      expect(@stats.avg_team_goals_season.class).to be Hash
      expect(@stats.avg_team_goals_season['3']).to eq(1.5)
    end

    it 'team id(s) with highest avg goals per game in season' do
      expect(@stats.max_avg_team_goals_season.class).to be Hash
      expect(@stats.max_avg_team_goals_season).to eq({"6"=>6.0})
    end

    it 'team id(s) with lowest avg goals per game in season' do
      expect(@stats.min_avg_team_goals_season.class).to be Hash
      expect(@stats.min_avg_team_goals_season).to eq({"5"=>0.33, "9"=>0.33})
    end

    it 'returns team(s) with highest avg goals per game'
  end
end