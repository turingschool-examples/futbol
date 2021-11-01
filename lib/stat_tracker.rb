require 'csv'

class StatTracker

  def initialize
    # @game_path = locations[:games]
    # @team_path = locations[:teams]
    # @game_teams_path = locations[:game_teams]
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def game_data(file_name)
    rows = CSV.read(file_name, headers: true)
    require "pry"; binding.pry
  end
end
