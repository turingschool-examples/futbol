require 'csv'
require_relative 'team'

class TeamCollection
  attr_reader :team_instances

  def initialize(team_path)
    @team_path = team_path
    @team_instances = all_teams
  end

  def all_teams
    csv = CSV.read("#{@team_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      Team.new(row)
    end
  end

  def highest_scoring_visitor(game_id) #these methods are the same - module
    team_instances.find do |team|
      team.team_id == game_id
    end.teamname
  end

  def highest_scoring_home_team(game_id) #these methods are the same - module
    team_instances.find do |team|
      team.team_id == game_id
    end.teamname
  end

  def lowest_scoring_visitor(game_id) #these methods are the same - module
    team_instances.find do |team|
      team.team_id == game_id
    end.teamname
  end

  def lowest_scoring_home_team(game_id) #these methods are the same - module
    team_instances.find do |team|
      team.team_id == game_id
    end.teamname
  end

  def count_of_teams
    id_list = @team_instances.map do |team|
      team.team_id
    end
    id_list.uniq.length
  end

  def winningest_team(team_id)
     @team_instances.reduce do |x, team|
      if team.team_id == team_id
        x = team.teamname
      end
      x
    end
  end
end
