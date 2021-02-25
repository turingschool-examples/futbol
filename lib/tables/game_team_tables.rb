require './lib/helper_modules/csv_to_hashable'
require './lib/instances/game_team.rb'

class GameTeamTable 
  include CsvToHash
  attr_reader :game_team_data, :teams
  def initialize(locations)
    from_csv(locations)
  end

end