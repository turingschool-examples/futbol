require './lib/stat_tracker'

RSpec.describe StatTracker do

  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it '1. exists' do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  it '3. can load an array of multiple CSVs' do
    expect(@stat_tracker.games).to be_a(CSV::Table)
    expect(@stat_tracker.teams).to be_a(CSV::Table)
    expect(@stat_tracker.game_teams).to be_a(CSV::Table)
  end

  context 'Season statistics' do
    it 'S1. has a method for winningest_coach' do
      expect(@stat_tracker.game_teams[:head_coach]).to include(@stat_tracker.winningest_coach)
      expect(@stat_tracker.winningest_coach). to eq "Claude Julien"
    end

    it 'S2. has a method for worst_coach' do
      expect(@stat_tracker.game_teams[:head_coach]).to include(@stat_tracker.worst_coach)
      expect(@stat_tracker.worst_coach). to eq "Patrick Roy"
    end

    it 'S3. can tell most_accurate_team' do
      expect(@stat_tracker.teams[:teamname]).to include(@stat_tracker.most_accurate_team)
      expect(@stat_tracker.most_accurate_team). to be_a String
    end




#   Season Statistics
# These methods each take a season id as an argument and return the values described below.
#
# Method	Description	Return Value
# most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
# least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
# most_tackles	Name of the Team with the most tackles in the season	String
# fewest_tackles	Name of the Team with the fewest tackles in the season	String
end
end
