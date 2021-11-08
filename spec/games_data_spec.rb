require './lib/stat_tracker'
require './lib/games_data'
require 'simplecov'
require 'csv'

RSpec.describe GamesData do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_test.csv'

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
    expect(game_obj.highest_total_score).to eq(5)
  end

  it '#lowest_total_score' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.lowest_total_score).to eq(1)
  end

  it '#percentage_home_wins' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.percentage_home_wins).to eq(68.42)
  end

  it '#percentage_visitor_wins' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.percentage_visitor_wins).to eq(26.32)
  end

  it '#percentage_ties' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.percentage_ties).to eq(5.26)
  end

  it '#sum_of_games_in_season' do
    game_obj = GamesData.new(@stat_tracker)

    expect(game_obj.sum_of_games_in_season('20122013')).to eq(17)
    expect(game_obj.sum_of_games_in_season('20132014')).to eq(1)
    expect(game_obj.sum_of_games_in_season('20142015')).to eq(1)
  end

  it '#count_of_games_by_season' do
    game_obj = GamesData.new(@stat_tracker)

    expected = {
      '20122013' => 17,
      '20132014' => 1,
      '20142015' => 1
    }
    expect(game_obj.count_of_games_by_season).to eq(expected)
  end

  it '#average_goals_per_game' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.average_goals_per_game).to eq(3.68)
  end

  it '#average_goals' do
    game_obj = GamesData.new(@stat_tracker)
    expect(game_obj.average_goals('20122013')).to eq(3.59)
    expect(game_obj.average_goals('20132014')).to eq(4.00)
    expect(game_obj.average_goals('20142015')).to eq(5.00)
  end

  it '#average_goals_by_season' do
    game_obj = GamesData.new(@stat_tracker)
    expected = {
      '20122013' => 3.59,
      '20132014' => 4.00,
      '20142015' => 5.00,
    }
    expect(game_obj.average_goals_by_season).to eq(expected)
  end

  # it 'can initliaze one ' do
  #   game_obj = GamesData.new(@stat_tracker)
  #
  #   expect(game_obj.game_data).to eq(@stat_tracker.games)
  # end
end
