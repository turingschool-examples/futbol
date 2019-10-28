require 'CSV'
require_relative './team'

class TeamCollection
  attr_reader :teams

  def self.load_data(path)
    teams = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      # require "pry"; binding.pry
      teams[row[:team_id]] = Team.new(row)
    end

    TeamCollection.new(teams)
  end

  def initialize(teams)
    @teams = teams
  end

  def team_count
    @teams.length
  end

  def team_name(team_id)
    @teams.find_all do |key, team_obj|
      key == team_id
    end.flatten[1].team_name
  end

end
