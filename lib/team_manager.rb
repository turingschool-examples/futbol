require 'CSV'
require 'pry'
require_relative './team'
require_relative './csv_parser'

class TeamManager
  include CsvParser

  def initialize(locations)
    @all_teams = load_it_up(locations, Team)
  end

  def count_of_teams
    @all_teams.count
  end

  def find_team_by_id(team_id)
    @all_teams.find do |team|
      team.team_id == team_id
    end
  end
end
