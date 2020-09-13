require_relative 'team'
require 'csv'

class TeamManager
  attr_reader :teams, :stat_tracker
  def initialize(location, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = generate_teams(location)
  end

  def generate_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Team.new(row.to_hash)
    end
    array
  end

  def team_info(id)
    teams.find do |team|
      team.team_id == id
    end.team_info
  end

  def game_ids_by_team(id)
    stat_tracker.games_by_team(id)
  end

  def game_team_info(game_id)
    stat_tracker.game_team_info(game_id)
  end

  def game_info(game_id)
    stat_tracker.game_info(game_id)
  end

  def gather_game_team_info(id)
    game_ids_by_team(id).map do |game_id|
      game_team_info(game_id)
    end
  end

  def most_goals_scored(id)
    gather_game_team_info(id).map do |game|
      game[id][:goals]
    end.max
  end

  def fewest_goals_scored(id)
    gather_game_team_info(id).map do |game|
      game[id][:goals]
    end.min
  end

  def total_wins(id, id2 = id)
    gather_game_team_info(id).count do |pair|
      next if pair[id2].nil?
      pair[id2][:result] == 'WIN'
    end
  end
end
