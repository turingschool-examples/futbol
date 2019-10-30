require 'csv'
require_relative 'team'

class TeamCollection
  attr_reader :team_instances, :team_path, :name

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

  def highest_scoring_visitor(game_id)  #these methods are the same - module
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
    name_finder(team_id)
  end

  def name_finder(id_of_team)
    #require 'pry'; binding.pry
    @name = []
    @team_instances.find do |team|
      if team.team_id == id_of_team
        @name << team.teamname
      end
    end
    @name.join
  end

  def worst_fans(team_id_list)
    team_list = []
    team_id_list.map do |team|
      team_list << name_finder(team)
      #require 'pry'; binding.pry
      end
    team_list.flatten
  end
end
