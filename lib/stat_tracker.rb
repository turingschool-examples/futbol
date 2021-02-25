require 'csv'
require 'active_support'
require './lib/csv_to_hashable.rb'
class StatTracker 
  include CsvToHash
  attr_reader :games, :game_teams, :teams, :data_hash, :locations
  def initialize(locations)
    from_csv(locations)
    @games = GameTable.new(@data_hash[:games])
    @game_teams = GameTeamTable.new(@data_hash[:game_teams])
    @teams = TeamsTable.new(@data_hash[:teams])
  end

  # def highest_score
  #   self.from_csv(csv_files)
    
  # end

  def send_team_data(teams)
    p teams
  end
  def random_task(data)
    p data
  end

end


