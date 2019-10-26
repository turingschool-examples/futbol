require_relative 'team'
require 'csv'

class TeamsCollection
  attr_reader :teams

  def initialize(teams_path)
    @teams = generate_objects_from_csv(teams_path)
  end

  def generate_objects_from_csv(csv_teams_path)
    objects = []
    CSV.foreach(csv_teams_path, headers: true, header_converters: :symbol) do |row_object|
      objects << Team.new(row_object)
    end
    objects
  end

  def name_of_team_by_id(team_id)
    @teams.find {|team| team.team_id == team_id}.team_name
  end

  def count_of_teams
    @teams.length
  end

  def team_info(team_id)
    team_data = {}
    @teams.each do |team|
      if team.team_id == team_id
        team_data["abbreviation"] = team.abbreviation
        team_data["franchise_id"] = team.franchise_id
        team_data["link"] = team.link
        team_data["team_id"] = team.team_id
        team_data["team_name"] = team.team_name
      end
    end
    team_data
  end

  def best_season(team_id)
    season = ""
    @teams.each do |team|
      if team.team_id == team_id
      end
    end
    season
  end
end
