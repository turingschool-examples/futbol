# require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

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

  it '#highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(5)
  end

  it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq(0.33)
  end

  it '#percentage_visitor_wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.33)
  end

  it '#percent_total_ties' do
    expect(@stat_tracker.percentage_ties).to eq(0.33)
  end
  it '#total_games' do
    expect(@stat_tracker.total_games).to eq(9)
  end

  it '#total_home_wins' do
    expect(@stat_tracker.total_home_wins).to eq(3)
  end

  it '#total_home_losses' do
    expect(@stat_tracker.total_home_losses).to eq(3)
  end

  it '#total_ties' do
    expect(@stat_tracker.total_ties).to eq(3)
  end

  it '#total_away_losses' do
    expect(@stat_tracker.total_away_losses).to eq(@stat_tracker.total_home_wins)
  end

  it '#total_away_wins' do
    expect(@stat_tracker.total_away_wins).to eq(@stat_tracker.total_home_losses)
  end

  it '#count_of_games_by_season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>4, "20142015"=>4, "20152016"=>1})
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.0)
  end

  it '#average_goals_by_season' do
    expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.5, "20142015"=>4.5, "20152016"=>4.0})
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored('8')).to eq(3)
  end

  it "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored('16')).to eq(0)
  end

  it "#most_tackles" do
    expect(@stat_tracker.most_tackles("20122013")).to eq "LA Galaxy"
    expect(@stat_tracker.most_tackles("20142015")).to eq "New York Red Bulls"
  end

  it "#fewest_tackles" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Chicago Red Stars"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "New York City FC"
  end

  it '#find_season' do
    expect(@stat_tracker.find_season('20122013').first).to be_a(CSV::Row)

    expect(@stat_tracker.find_season('20102011')).to eq([])
  end

  it '#total_goals' do
    expect(@stat_tracker.total_goals('20122013')).to eq({"17"=>6.0, "16"=>2.0})
  end

  it '#total_shots' do
    expect(@stat_tracker.total_shots('20122013')).to eq({"17"=>19.0, "16"=>18.0})
  end

  it '#most_accurate_team' do
    expect(@stat_tracker.most_accurate_team('20142015')).to eq('New York Red Bulls')
  end

  it '#least_accurate_team' do
    expect(@stat_tracker.least_accurate_team('20142015')).to eq('New York City FC')
  end

  it '#total_games_played_per_team(season)' do
    expect(@stat_tracker.total_games_played_per_team("20122013")).to eq({"Mike Babcock"=>3, "Joel Quenneville"=>2})
  end

  it '#total_wins_per_team(season)' do
    expect(@stat_tracker.total_wins_per_team('20122013')).to eq({"Mike Babcock"=>2, "Joel Quenneville"=>1})
  end

  it '#winningest_coach(season)' do
    expect(@stat_tracker.winningest_coach('20122013')).to eq("Mike Babcock")
  end

  it '#worst_coach(season)' do
    expect(@stat_tracker.worst_coach('20122013')).to eq("Joel Quenneville")
  end

end
