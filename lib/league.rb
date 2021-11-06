require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './stat_tracker.rb'
class League
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data)
    @games = data[:games]
    @teams = data[:teams]
    @game_teams = data[:game_teams]
  end

  def highest_total_score

    game_id_hash = @game_teams.group_by do |game_team|
      game_team.game_id
    end

    sum_of_goals_each_game = []
    game_id_hash.each_pair do |key, value|
      sum_of_goals_each_game << value[0].goals.to_i + value[1].goals.to_i
    end
    sum_of_goals_each_game.max
  end

  def lowest_total_score

    game_id_hash = @game_teams.group_by do |game_team|
      game_team.game_id
    end

    sum_of_goals_each_game = []
    game_id_hash.each_pair do |key, value|
      sum_of_goals_each_game << value[0].goals.to_i + value[1].goals.to_i
    end
    sum_of_goals_each_game.min
  end

  def count_of_teams
    @teams.count
  end

end
