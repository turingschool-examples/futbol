require './lib/stat_tracker.rb'
require_relative 'spec_helper.rb'


describe StatTracker do

    describe '.from_csv(locations)' do
        it 'returns an instance of StatTracker' do

            game_path = './data/games.csv'
            team_path = './data/teams.csv'
            game_teams_path = './data/game_teams.csv'

            locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
            }

            expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)

        end

        it "text" do
          game_path = './data/games.csv'
          team_path = './data/teams.csv'
          game_teams_path = './data/game_teams.csv'

          locations = {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
          }
          stat_tracker = StatTracker.from_csv(locations)

          expect(stat_tracker.games).to eq(CSV.table(game_path))
          expect(stat_tracker.teams).to eq(CSV.table(team_path))
          expect(stat_tracker.game_teams).to eq(CSV.table(game_teams_path))
        end
    end
end
