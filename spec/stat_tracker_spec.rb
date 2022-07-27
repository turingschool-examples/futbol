require_relative '../lib/stat_tracker'



RSpec.describe do
  before :each do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 11
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  it "#percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.20
  end

  it "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@stat_tracker.count_of_games_by_season).to eq expected
  end

  it "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end

  it "#average_goals_by_season" do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end
  #league stats tests v
  it 'can return the total number of teams in the data' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it 'can return team name with the highest average num of goals scored per games across all seasons' do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it 'can return team name with lowest avg num of goals scored per game across all seasons' do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it 'can return team name with highest avg score per game across all season when they are AWAY' do 
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'can return team name with the highest avg score per game across alls eason when they are HOME' do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it 'can return team name with lowest avg score per game across all seasons when they are a VISITOR' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it 'can return team name with lowest avg score per game across all seasons when they are at HOME' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end
end