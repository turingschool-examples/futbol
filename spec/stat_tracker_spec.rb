require './spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './fixtures/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixtures/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe 'initialization' do
    it 'exists' do
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it 'has RawStats' do
      expect(@stat_tracker.stats).to be_a(RawStats)
    end
  end

  describe 'Game Statistics' do
    it 'calculates highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end
  
    it 'calculates lowest_total_score' do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end
  
    it 'calculates percentage_home_wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.65)
    end
  
    it 'calculates percentage_visitor_wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.33)
    end
  
    it 'calculates percentage_ties' do
      expect(@stat_tracker.percentage_ties).to eq(0.02)
    end
  
    it 'calculates count_of_games_by_season' do
      expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>49})
    end
  
    it 'calculates average_goals_per_game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.92)    
    end
  
    it 'calculates average_goals_by_season' do
      expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.92}) 
    end  
  end

  describe 'League Statistics' do
    it 'calculates count_of_teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    it 'has average_goals_by_team list (hash)' do
      expect(@stat_tracker.avg_goals_by_team).to be_a(Hash)
      expected = {"16"=>1.82, "17"=>1.86, "3"=>1.6, "30"=>2.0, "5"=>0.5, "6"=>2.67, "8"=>1.8, "9"=>2.8}

      expect(@stat_tracker.avg_goals_by_team).to eq(expected)
    end
  
    it 'calculates best_offense' do
      expect(@stat_tracker.best_offense).to eq("New York City FC")
    end
  
    it 'calculates worst_offense' do
      expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
    end
  
    it 'calculates highest_scoring_visitor' do
      #code here
    end
  
    it 'calculates highest_scoring_home_team' do
      #code here
    end
  
    it 'calculates lowest_scoring_visitor' do
      #code here
    end
  
    it 'calculates lowest_scoring_home_team' do
      #code here
    end
  end

  describe 'Season Statistics' do
    it 'calculates winningest_coach' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
    end
  
    it 'calculates worst_coach' do
      #code here
    end
  
    it 'calculates most_accurate_team' do
      #code here
    end
  
    it 'calculates least_accurate_team' do
      #code here
    end
  
    it 'calculates most_tackles' do
      #code here
    end
  
    it 'calculates fewest_tackles' do
      #code here
    end
  end
end