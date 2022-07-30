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
  expect(stat_tracker.highest_total_score).to eq 11
   end

  it "#lowest_total_score" do
    expect(stat_tracker.lowest_total_score).to eq 0
  end

  it "#percentage_home_wins" do
    expect(stat_tracker.percentage_home_wins).to eq 0.44
  end

  it '#percentage_visitor_wins' do
    expect(stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  it '#percentage_ties' do
    expect(stat_tracker.percentage_ties).to eq 0.20
  end

  it '#count_of_games_by_season' do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(stat_tracker.count_of_games_by_season).to eq expected
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


# # # League Statistics

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

# # # Season Statistics

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

# # # Team Statistics

  it '#team_info' do
    expect(stat_tracker.team_info(28)).to eq({:abbreviation=> "LFC", :franchise_id=> "29", :link=> "/api/v1/teams/28", :team_id=> "28", :team_name=> "Los Angeles FC"})
  end

  it '#best_season' do
    expect(stat_tracker.best_season(28)).to eq '20152016'
  end

  it '#worst_season' do
    expect(stat_tracker.worst_season(28)).to eq '20122013'
  end

  it '#average_win_percentage' do
    expect(stat_tracker.average_win_percentage(28)).to eq 44.77
  end

  it '#most_goals_scored' do
    expect(stat_tracker.most_goals_scored(28)).to eq "7"
  end

  it '#fewest_goals_scored' do
    expect(stat_tracker.fewest_goals_scored(28)).to eq 0
  end

  it '#favorite_opponent' do
    expect(stat_tracker.favorite_opponent(28)).to eq 'Montreal Impact'

  end

  it '#rival' do
    expect(stat_tracker.rival(28)).to eq 'Sporting Kansas City'
  end
end