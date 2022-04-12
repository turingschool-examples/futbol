require './lib/stat_tracker'

RSpec.describe StatTracker do
    
    it 'exists and has attributes' do 
        stat_tracker = StatTracker.new

        expect(stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'can call #from_csv on self' do 
        stat_tracker = StatTracker.new

        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
          }
        
        expect(self.from_csv(locations)).to eq({
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
          })
    end
end