require 'csv'
require_relative 'team.rb'

class LeagueStats < Team
  attr_reader :game_teams, 
              :games 

  def initialize(file_1, file_2)
    @game_teams = self.format(file_1)
    @games      = self.format(file_1)
  end 

  def format(file)
    league_file = CSV.read(file, headers: true, header_converters: :symbol)
    league_file.map do |row|
      Team.new(row)
    end
  end

  def count_of_teams
    @game_teams.count
  end

  def best_offense 
    
  end
end