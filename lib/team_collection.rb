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

  def array_of_team_ids
    id_list = @team_instances.map do |team|
      team.team_id
    end
    id_list.uniq
  end

  def worst_defense
    team_and_goals_against = GameCollection.new('./dummy_data/dummy_games.csv')
    worst_team_key_value = team_and_goals_against.worst_defense[0]
    worst_teams = @team_instances.select do |team|
      if worst_team_key_value == team.team_id
        team.teamname
      end
    end
    worst_teams_array = []
    worst_teams.each do |team|
      worst_teams_array << team.teamname
    end
    worst_teams_string = worst_teams_array.join
  end

  def best_defense
    team_and_goals_against = GameCollection.new('./dummy_data/dummy_games.csv')
    best_team_key_value = team_and_goals_against.best_defense
    best_teams = @team_instances.select do |team|
      if best_team_key_value.include?(team.team_id)
        team.teamname
      end
    end
    best_teams_array = []
    best_teams.each do |team|
      best_teams_array << team.teamname
    end
    best_teams_string = best_teams_array.join(", ")
  end

end
