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

  # xit '#combined_home_and_away_team_goals' do
  #   expect(@league.combined_home_and_away_team_goals).to eq({"3"=>2, "6"=>10, "16"=>9, "17"=>6, "12"=>7, "14"=>7})
  # end
  #
  it 'can convert team ids to name' do
    expect(@league.convert_team_id_to_name(24)).to eq('Real Salt Lake')
  end

  it 'can return the best offense in data' do
    expect(@league.best_offense).to eq('Portland Thorns FC')
  end
end
