require 'csv'
require './lib/stat_tracker'

RSpec.describe League do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol

    @league = League.new(@games, @teams, @game_teams)
    # @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists' do
    expect(@league).to be_instance_of(League)
  end

  it 'can count total teams in data' do
    expect(@league.count_of_teams).to eq(32)
  end

  it 'can convert team ids to name' do
    expect(@league.convert_team_id_to_name("24")).to eq('Real Salt Lake')
  end

  it 'can group game_teams by team_id' do
    expect(@league.games_by_team_id.class).to eq(Hash)
    expect(@league.games_by_team_id.keys[0]).to eq("15")
  end

  it 'can return a collection of all goals per team' do
    expected = {
      "15"=>[2.0, 1.0, 4.0, 2.0],
      "5"=>[3.0, 3.0, 3.0, 1.0],
      "30"=>[2.0, 1.0, 4.0, 0.0, 0.0, 3.0],
      "52"=>[3.0, 2.0, 2.0, 2.0, 3.0],
      "19"=>[1.0],
      "23"=>[2.0],
      "24"=>[3.0, 3.0, 3.0],
      "4"=>[2.0],
      "29"=>[2.0, 2.0],
      "12"=>[2.0],
      "6"=>[4.0],
      "17"=>[2.0],
      "1"=>[3.0],
      "2"=>[0.0],
      "26"=>[3.0],
      "18"=>[0.0],
      "28"=>[3.0, 3.0]
    }
    expect(@league.collection_of_goals_per_team).to eq(expected)
  end

  it 'can return a hash with total number of goals' do
    expected = {
      "15"=> 9.0,
      "5"=> 10.0,
      "30"=> 10.0,
      "52"=> 12.0,
      "19"=> 1.0,
      "23"=> 2.0,
      "24"=> 9.0,
      "4"=> 2.0,
      "29"=> 4.0,
      "12"=> 2.0,
      "6"=> 4.0,
      "17"=> 2.0,
      "1"=> 3.0,
      "2"=> 0.0,
      "26"=> 3.0,
      "18"=> 0.0,
      "28"=> 6.0
    }
    expect(@league.total_goals_per_team).to eq(expected)
  end
end
