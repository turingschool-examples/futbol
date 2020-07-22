require_relative './team'
require 'csv'

class TeamsCollection

  attr_reader :path,
              :all_teams
  def initialize(path)
    @path      = path
    @all_teams = []
  end

  def from_csv(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |team_data|
      add_team(team_data)
    end
  end

  def add_team(data)
    @all_teams << Team.new(data)
  end

end
