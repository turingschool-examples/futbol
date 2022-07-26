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

  xit '#highest_total_score' do
  
  end

  xit '#lowest_total_score' do
  
  end

  xit '#percentage_home_wins' do
    
  end

  xit '#percentage_visxitor_wins' do

  end

  xit '#percentage_ties' do

  end

  xit '#count_of_games_by_season' do

  end

  xit '#average_goals_per_game' do

  end

  xit '#average_goals_by_season' do

  end


# League Statistics

  it '#count_of_teams' do
    expect(stat_tracker.count_of_teams).to eq 32

  end

  xit '#best_offense' do

  end

  xit '#worst_offense' do

  end

  xit '#highest_scoring_visitor' do

  end

  xit '#highest_scoring_home_team' do

  end

  xit '#lowest_scoring_visitor' do

  end

  xit '#lowest_scoring_home_team' do

  end


# Season Statistics

  xit '#winningest_coach' do

  end

  xit '#worst_coach' do

  end

  it '#most_accurate_team' do
    expect(stat_tracker.most_accurate_team).to be_a(String)
  end

  it '#least_accurate_team' do
    expect(stat_tracker.least_accurate_team).to be_a(String)
  end

  it '#most_tackles' do
    
    expect(stat_tracker.most_tackles).to be_a(String)
  end

  it '#fewest_tackles' do
    expect(stat_tracker.fewest_tackles).to be_a(String)
  end


# Team Statistics

  xit '#team_info' do

  end

  xit '#best_season' do

  end

  xit '#worst_season' do

  end

  xit '#average_win_percentage' do

  end

  xit '#most_goals_scored' do

  end

  xit '#fewest_goals_scored' do

  end

  xit '#favorxite_opponent' do

  end

  xit '#rival' do

  end
end

