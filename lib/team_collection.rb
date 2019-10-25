require 'csv'
require_relative './team.rb'

class TeamCollection
  attr_reader :total_teams

  def initialize(team_path)
    @total_teams = create_teams(team_path)
  end

  def create_teams(team_path)
    csv = CSV.read(team_path, headers: true, header_converters: :symbol)
    csv.map do |row|
      Team.new(row)
    end
  end
end
