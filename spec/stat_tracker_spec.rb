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

  it '#average_goals_per_game' do
    expect(stat_tracker.average_goals_per_game).to eq 4.22
  end

  it '#average_goals_by_season' do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(stat_tracker.average_goals_by_season).to eq expected
  end


# League Statistics

  it '#count_of_teams' do
    expect(stat_tracker.count_of_teams).to eq 32
  end

  it '#best_offense' do
    expect(stat_tracker.best_offense).to eq "Reign FC"
  end

  it '#worst_offense' do
    expect(stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  it '#highest_scoring_visitor' do
    expect(stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

  it '#highest_scoring_home_team' do
    expect(stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  it '#lowest_scoring_visitor' do
    expect(stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  it '#lowest_scoring_home_team' do
    expect(stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end


# Season Statistics

  it '#winningest_coach' do
    expect(stat_tracker.winningest_coach).to eq("Dan Lacroix")
  end

  it '#worst_coach' do
    expect(stat_tracker.worst_coach).to eq("Martin Raymond")
  end

  it '#most_accurate_team' do
    expect(stat_tracker.most_accurate_team).to eq("Chicago Red Stars")
  end

  it '#least_accurate_team' do
    expect(stat_tracker.least_accurate_team).to eq("New England Revolution")
  end

  it '#most_tackles' do

    expect(stat_tracker.most_tackles).to eq("Orlando Pride")
  end

  it '#fewest_tackles' do
    expect(stat_tracker.fewest_tackles).to eq("Philadelphia Union")
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

