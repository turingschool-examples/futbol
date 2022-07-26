require './lib/stat_tracker'

RSpec.describe StatTracker do

  it '1. exists' do
    team_path = './data/teams.csv'
    location = team_path
    stat_tracker = StatTracker.new(location)

    expect(stat_tracker).to be_an_instance_of StatTracker
  end

  it '2. can load filepath' do
    team_path = './data/teams.csv'
    location = team_path
    stat_tracker = StatTracker.new(location)
    # require "pry"; binding.pry
    expect(stat_tracker.data.headers).to eq [:team_id,:franchiseid,:teamname,:abbreviation,:stadium,:link]
  end

  it '3. can load an array of multiple CSVs' do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker).to be_a Hash
    expect(stat_tracker.keys).to eq([:games, :teams, :game_teams])
    expect(stat_tracker.values).to all be_an_instance_of StatTracker
  end

  context 'Season statistics' do
    it 'S1. has a method for winningest_coach' do
      team_path = './data/game_teams_dummy.csv'
      location = team_path
      stat_tracker = StatTracker.new(location)

      expect(stat_tracker.data[:head_coach]).to include(stat_tracker.winningest_coach)
      expect(stat_tracker.winningest_coach). to eq "Claude Julien"
    end

    it 'S2. has a method for worst_coach' do
      team_path = './data/game_teams_dummy.csv'
      location = team_path
      stat_tracker = StatTracker.new(location)

      expect(stat_tracker.data[:head_coach]).to include(stat_tracker.worst_coach)
      expect(stat_tracker.worst_coach). to eq "Patrick Roy"
    end




#   Season Statistics
# These methods each take a season id as an argument and return the values described below.
#
# Method	Description	Return Value

# worst_coach	Name of the Coach with the worst win percentage for the season	String
# most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
# least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
# most_tackles	Name of the Team with the most tackles in the season	String
# fewest_tackles	Name of the Team with the fewest tackles in the season	String
end
end
