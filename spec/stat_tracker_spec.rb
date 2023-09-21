require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    ## LOCATING CSV FILES
    game_teams_path = './data/game_team_fixture.csv'
    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
    @locations = {  game_teams: game_teams_path, 
                    games: game_path, 
                    teams: team_path,
                  }

    @stats = StatTracker.from_csv(@locations)
  end
  
  describe '#initialize' do
    it 'exists' do
      expect(@stats).to be_instance_of(StatTracker)
    end
    
    it 'has attributes' do
      expect(@stats.all_data.values.all? { |file| File.exist?(file) } ).to be true
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
      expect(@stats.count_of_games_by_season).to eq({ "20122013"=>19, 
                                                      "20152016"=>33, 
                                                      "20162017"=>36, 
                                                      "20172018"=>35})
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
      expect((@stats.percentage_ties + @stats.percentage_home_wins + @stats.percentage_visitor_wins).round).to eq(1)
    end

    it 'returns average number of goals scored in a game across all seasons' do
      expect(@stats.average_goals_per_game).to eq(3.91)
      expect(@stats.average_goals_per_game.class).to be Float
    end

    it 'returns average number of goals scored in a game' do
      expect(@stats.average_goals_by_season).to eq({"20122013"=>3.42, 
                                                    "20152016"=>4.15, 
                                                    "20162017"=>4.44, 
                                                    "20172018"=>4.26})
      expect(@stats.average_goals_by_season.class).to be Hash
    end

  end
end