require 'spec_helper'

RSpec.describe StatTracker do
  let!(:game_path) { './data/games.csv' }
  let!(:team_path) { './data/teams.csv' }
  let!(:game_teams_path) { './data/game_teams.csv' }
  
  let!(:locations) { {games: game_path, teams: team_path, game_teams: game_teams_path } }

  let!(:stat_tracker) { StatTracker.from_csv(locations) }
  context 'stat_tracker instantiates' do
    it 'should have a class' do
      expect(stat_tracker).to be_a StatTracker
    end

    it 'self method should be an instance of the class' do
      expect(StatTracker.from_csv(locations)).to be_a StatTracker
    end
  end


  it '#highest_total_score' do
   
  end

  it '#lowest_total_score' do
  
  end

  it '#percentage_home_wins' do
    
  end

  it '#percentage_visitor_wins' do

  end

  it '#percentage_ties' do

  end

  it '#count_of_games_by_season' do

  end

  it '#average_goals_per_game' do

  end

  it '#average_goals_by_season' do

  end


# League Statistics

  it '#count_of_teams' do

  end

  it '#best_offense' do

  end

  it '#worst_offense' do

  end

  it '#highest_scoring_visitor' do

  end

  it '#highest_scoring_home_team' do

  end

  it '#lowest_scoring_visitor' do

  end

  it '#lowest_scoring_home_team' do

  end


# Season Statistics

  it '#winningest_coach' do

  end

  it '#worst_coach' do

  end

  it '#most_accurate_team' do

  end

  it '#least_accurate_team' do

  end

  it '#most_tackles' do

  end

  it '#fewest_tackles' do

  end


# Team Statistics

  it '#team_info' do

  end

  it '#best_season' do

  end

  it '#worst_season' do

  end

  it '#average_win_percentage' do

  end

  it '#most_goals_scored' do

  end

  it '#fewest_goals_scored' do

  end

  it '#favorite_opponent' do

  end

  it '#rival' do

  end
end

