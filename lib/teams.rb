require_relative './stat_tracker'
require 'csv'

class Teams
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def self.create_multiple_teams(location)
    teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    teams_as_objects = teams.map { |row| Teams.new(row) }
  end

  def initialize(team_info)
  @team_id = team_info[:team_id]
  @franchise_id = team_info[:franchiseid]
  @team_name = team_info[:teamname]
  @abbreviation = team_info[:abbreviation]
  @stadium = team_info[:Stadium]
  @link = team_info[:link]
  end


end
