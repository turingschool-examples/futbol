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
    expect(@stat_tracker.percentage_home_wins).to eq(0.60)
  end

  it '#percentage_visitor_wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.40)
  end

  it '#percent_total_ties' do
    expect(@stat_tracker.percentage_ties).to eq(0)
  end
  it '#total_games' do
    expect(@stat_tracker.total_games).to eq(10)
  end

  it '#total_home_wins' do
    expect(@stat_tracker.total_home_wins).to eq(6)
  end

  it '#total_home_losses' do
    expect(@stat_tracker.total_home_losses).to eq(4)
  end

  it '#total_ties' do
    expect(@stat_tracker.total_ties).to eq(0)
  end

  it '#total_away_losses' do
    expect(@stat_tracker.total_away_losses).to eq(@stat_tracker.total_home_wins)
  end

  it '#total_away_wins' do
    expect(@stat_tracker.total_away_wins).to eq(@stat_tracker.total_home_losses)
  end

  it '#count_of_games_by_season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>10})
  end

  it '#average_goals_per_game' do
    expect(@stat_tracker.average_goals_per_game).to eq(3.7)
  end

  it '#average_goals_by_season' do
    expect(@stat_tracker.average_goals_by_season).to eq({"20122013" => 3.70})
  end

  it '#count_of_teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it '#average_goals' do
    expect(@stat_tracker.average_goals).to eq({"17"=>2.0, "16"=>1.5, "9"=>2.0, "8"=>2.5})
  end

  it '#best_offense' do
    expect(@stat_tracker.best_offense).to eq('New York Red Bulls')
  end

  it '#worst_offense' do
    expect(@stat_tracker.worst_offense). to eq('New England Revolution')
  end

  it '#highest_scoring_visitor' do
    expect(@stat_tracker.highest_scoring_visitor).to eq('New York City FC')
  end

  it '#highest_scoring_home_team' do
    expect(@stat_tracker.highest_scoring_home_team).to eq('LA Galaxy')
  end

  it '#lowest_scoring_visitor' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq('New England Revolution')
  end

  it '#lowest_scoring_home_team' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq('New England Revolution')
  end

  it '#team_info' do
    expect(@stat_tracker.team_info('18')).to eq({
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    })
  end

  it '#total_wins_per_season' do
    expect(@stat_tracker.total_wins_per_season('6')).to eq({"20122013"=>9})
  end

  it '#total_games_played_per_season' do
    expect(@stat_tracker.total_games_played_per_season('6')).to eq({"20122013"=>9})
  end

  it '#best_season' do
    expect(@stat_tracker.best_season('6')).to eq("20122013")
  end

  it '#worst_season' do
    expect(@stat_tracker.worst_season('6')).to eq("20122013")
  end

  it '#average_win_percentage' do
    expect(@stat_tracker.average_win_percentage('6')).to eq(1)
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored('8')).to eq(3)
  end

  it "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored('16')).to eq(0)
  end

  it '#favorite_opponent' do
    require 'pry';binding.pry
    expect(@stat_tracker.favorite_opponent('16')).to be_a String
  end
end
