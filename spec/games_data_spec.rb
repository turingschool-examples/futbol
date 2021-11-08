require './lib/stat_tracker'
require './lib/games_data'
require 'simplecov'
require 'csv'

RSpec.describe GamesData do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'is exists' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj).to be_instance_of(GamesData)
  end

  it 'can store and access games data' do
    game_obj = GamesData.new(@stat_tracker)

    expect(game_obj.game_data).to eq(@stat_tracker.games)
  end

  it '#highest_total_score' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.highest_total_score).to eq(11)
  end

  it '#lowest_total_score' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.lowest_total_score).to eq(0)
  end

  it '#percentage_home_wins' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.percentage_home_wins).to eq(43.5)
  end

  it '#percentage_visitor_wins' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.percentage_visitor_wins).to eq(36.11)
  end

  it '#percentage_ties' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.percentage_ties).to eq(20.39)
  end

  it '#sum_of_games_in_season' do
    game_obj = GamesData.new(@stat_tracker)

    expect(game_obj.sum_of_games_in_season('20122013')).to eq(806)
    expect(game_obj.sum_of_games_in_season('20132014')).to eq(1323)
    expect(game_obj.sum_of_games_in_season('20142015')).to eq(1319)
  end

  it '#count_of_games_by_season' do
    game_obj = GamesData.new(@stat_tracker)

    expected = {
      '20122013' => 806,
      '20132014' => 1323,
      '20142015' => 1319,
      "20152016" => 1321,
      "20162017"=> 1317,
      "20172018"=>1355
    }
    expect(game_obj.count_of_games_by_season).to eq(expected)
  end

  it '#average_goals_per_game' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.average_goals_per_game).to eq(4.22)
  end

  it '#average_goals' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.average_goals('20122013')).to eq(4.12)
    expect(game_obj.average_goals('20132014')).to eq(4.19)
    expect(game_obj.average_goals('20142015')).to eq(4.14)
  end

  it '#average_goals_by_season' do
    game_obj = GamesData.new(@stat_tracker)
    expected = {
      '20122013' => 4.12,
      '20132014' => 4.19,
      '20142015' => 4.14,
      "20152016"=>4.16,
      "20162017"=>4.23,
      "20172018"=>4.44
    }
    expect(game_obj.average_goals_by_season).to eq(expected)
  end

end
