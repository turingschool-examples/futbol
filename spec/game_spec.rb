require 'spec_helper'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe Game do
    it 'exists' do
        
    end
# create variables of the games stuff below
2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null
2012030222,20122013,Postseason,5/19/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null

end