require './lib/helper_modules/csv_to_hashable.rb'

class GameTeamTable < StatTracker
  include CsvToHash
  attr_reader :game_team_data, :teams
  def initialize(locations)
    @game_team_data = from_csv(locations)
  end

  def random_task
    
  end
  def send_team_data
    super()
  end
  def get_table_data
    super
  end
end