require_relative './game'
require_relative './team'
require_relative './game_team'

class LeagueStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  def count_of_teams
    @teams_collection.teams.count
  end

  def unique_team_ids
    ids = @game_teams_collection.game_teams.each do |game_team|
      game_team.team_id
    end
    ids.map do |game_team|
      game_team.team_id
    end.uniq
  end

  def games_sorted_by_team_id(team_id)


  end

  def average_goals_per_team_id(team_id)


  end

  # def best_offense
  #   @game_teams_collection.game_teams.each do |team|
  #     team.goals
  #   end


  # end

  def worst_offense

  end
end
