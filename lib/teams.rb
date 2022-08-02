require_relative './stat_tracker'
require 'csv'

class Teams
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(team_info)
  @team_id = team_info[:team_id]
  @franchise_id = team_info[:franchiseid]
  @team_name = team_info[:teamname]
  @abbreviation = team_info[:abbreviation]
  @stadium = team_info[:Stadium]
  @link = team_info[:link]
  end
end
