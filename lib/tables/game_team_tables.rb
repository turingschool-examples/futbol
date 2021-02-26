require './lib/helper_modules/csv_to_hashable'
require './lib/instances/game_team'

class GameTeamTable 
  include CsvToHash
  attr_reader :game_team_data, :teams
  def initialize(locations)
    @game_team_data = from_csv(locations, 'GameTeam')
  end

end