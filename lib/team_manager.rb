require 'CSV'
require 'pry'

require_relative './teams'

class TeamManager
  attr_reader :team_objects, :team_path

  def initialize(team_path)
    @team_path = './data/teams.csv'
    @team_objects = CSV.read(team_path, headers: true, header_converters: :symbol).map {|row| Teams.new(row)}
  end

  def count_of_teams
    @team_objects.count
  end

  def team_info(team_id)
  pick = @team_objects.find {|team| team.team_id.to_s == team_id}
{
  "team_id" => pick.team_id.to_s,
  "franchise_id" => pick.franchiseid.to_s,
  "team_name" => pick.teamname,
  "abbreviation" => pick.abbreviation,
  "link" => pick.link
}
  end
end
