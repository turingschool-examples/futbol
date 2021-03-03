require_relative './team'
require 'CSV'

class TeamsManager
  attr_reader :teams

  def initialize(data_path)
    @teams = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Team.new(row)
    end
    list_of_data
  end

  def count_of_teams
    teams.uniq.count
  end

  def get_team_name(team_id)
    team_names_hash = {}
    @teams.each do |team|
      team_names_hash[team.team_id] = team.team_name
    end
    team_names_hash[team_id]
  end

  def team_info(team_id)
    desired_team = @teams.find do |team|
      team.team_id == team_id
    end

     { "team_id" => desired_team.team_id,
       "franchise_id" => desired_team.franchise_id,
       "team_name" => desired_team.team_name,
       "abbreviation" => desired_team.abbreviation,
       "link" => desired_team.link}
  end
end
