require 'csv'
require_relative 'team.rb'

class LeagueStats < Team
  attr_reader :leagues

  def initialize(file)
    @leagues = self.format(file)
  end 

  def format(file)
    league_file = CSV.read(file, headers: true, header_converters: :symbol)
    league_file.map do |row|
      Team.new(row)
    end
  end

  def count_teams

  end
end