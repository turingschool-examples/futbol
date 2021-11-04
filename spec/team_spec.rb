require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Team Class Tests'
require './lib/team'

# RSpec.describe Team do
#   #ask about team_creation because it is already tested
#   # let!(:stat_tracker) do
#   #   game_path = './spec/fixtures/spec_games.csv'
#   #   team_path = './spec/fixtures/spec_teams.csv'
#   #   game_teams_path = './spec/fixtures/spec_game_teams.csv'
#   #
#   #   locations = {
#   #     games: game_path,
#   #     teams: team_path,
#   #     game_teams: game_teams_path
#   #   }
#   #   StatTracker.from_csv(locations)
#   # end
#   # let!(:game_data){stat_tracker.game_data}
#   # let!(:team_data){stat_tracker.team_data}
#   # let!(:game_team_data){stat_tracker.game_team_data}
#   # let!(:creator) { Creator.create_objects(game_data, team_data, game_team_data) }
#   # let(:team1) { Team.new(team_data, team_games) }
#
#   describe '#initialize' do
#     xit 'exists' do
#       expect(team1).to be_instance_of(Team)
#     end
#   end
# end
