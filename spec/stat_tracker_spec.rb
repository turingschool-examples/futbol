# require '../futbol/lib/stat_tracker'
# require 'rspec/mocks/standalone'

# RSpec.describe StatTracker do
#   before(:each) do
#     game_double = double('Game')
#     team_double = double('Team')
#     game_team_double = double('GameTeam')

#     # Set up stubbed return values for the game double's methods
#     allow(game_double).to receive(:game_id).and_return('1')
#     allow(game_double).to receive(:season_id).and_return('374')
#     allow(game_double).to receive(:season_type).and_return('postseason')
#     allow(game_double).to receive(:game_date).and_return('5/16/13')
#     allow(game_double).to receive(:away_team_id).and_return(5)
#     allow(game_double).to receive(:home_team_id).and_return(6)
#     allow(game_double).to receive(:away_goals).and_return(2)
#     allow(game_double).to receive(:home_goals).and_return(3)
#     allow(game_double).to receive(:venue_name).and_return('Toyota Stadium')
#     allow(game_double).to receive(:venue_link).and_return('/api/v1/venues/null')

#     @games = [game_double]
#     @teams = [team_double]
#     @game_teams = [game_team_double]

#     allow_any_instance_of(StatTracker).to receive(:game_init).and_return(@games)
#     allow_any_instance_of(StatTracker).to receive(:teams_init).and_return(@teams)
#     allow_any_instance_of(StatTracker).to receive(:game_teams_init).and_return(@game_teams)
#   end

#   # Use a `let` statement to create the StatTracker object.
#   let(:stat_tracker) { StatTracker.new({}) }

#   describe '#home_win?' do
#     it 'returns true when the home team has more goals' do
#       expect(stat_tracker.home_win?).to be true
#     end
#   end

#   describe '#away_win?' do
#     it 'returns false when the away team has fewer goals' do
#       expect(stat_tracker.away_win?).to be false
#     end
#   end

#   describe '#game_tie?' do
#     it 'returns false when the home team and away team have a different number of goals' do
#       expect(stat_tracker.game_tie?).to be false
#     end
#   end
# end
