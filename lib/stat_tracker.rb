# require_relative 'csv'
# require_relative 'pry'
require_relative './game'
require_relative './team'
require_relative './game_team'


class StatTracker

  attr_reader :games,
              :teams,
              :game_teams
  def initialize(games, teams, game_teams)
    @games      = games
    @teams      = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    CSV.parse(File.read(locations[:games]), headers: true).each do |row|
       games << Game.new(row)
    end
    teams = []
    CSV.parse(File.read(locations[:teams]), headers: true).each do |row|
      teams << Team.new(row)
    end
    game_teams = []
    CSV.parse(File.read(locations[:game_teams]), headers: true).each do |row|
      game_teams << GameTeam.new(row)
    end
    ted_lasso = StatTracker.new(games, teams, game_teams)
    require "pry"; binding.pry
    return ted_lasso
  end

  def highest_total_score
    grouped_by_game = @game_teams.group_by do |row|
      row["game_id"]
    end
    game_sum_goals = []
    grouped_by_game.each_pair do |key, value|
      first_team_goals = value.first["goals"].to_i
      second_team_goals = value.last["goals"].to_i
      game_sum_goals << first_team_goals + second_team_goals
    end
    game_sum_goals.max
  end

  def lowest_total_score
    grouped_by_game = @game_teams.group_by do |row|
      row["game_id"]
    end
    game_sum_goals = []
    grouped_by_game.each_pair do |key, value|
      first_team_goals = value.first["goals"].to_i
      second_team_goals = value.last["goals"].to_i
      game_sum_goals << first_team_goals + second_team_goals
    end
    game_sum_goals.min
  end

  def percentage_visitor_wins
    away_team_hash = @game_teams.group_by do |row|
                              row["HoA"]
                      end

    away_team_wins = away_team_hash["away"].select do |game|
      game["result"] == "WIN"
    end

    ((away_team_wins.length.to_f / away_team_hash["away"].length.to_f) *100).ceil(2)
      #require "pry"; binding.pry
  end

  def percentage_ties
    result_hash = @game_teams.group_by do |row|
                              row["result"]
                      end
    require "pry"; binding.pry

    ((result_hash["TIE"].length.to_f / result_hash.each_value) *100).ceil(2)
      #require "pry"; binding.pry

  end



  # def percentage_home_wins
  #   home_team_hash = @game_teams.group_by do |row|
  #     row["HoA"]
  #   end
  #   home_team_wins = home_team_hash["home"].select do |game|
  #     game["result"] == "WIN"
  #   end
  #   ((home_team_wins.length.to_f / home_team_hash["home"].length.to_f) * 100).ceil(2)
  # end

  def percentage_home_wins
    home_team_winners = @game_teams.select do |game_team|
      game_team.home? && game_team.won?
    end

    ((home_team_winners.length.to_f / home_team_hash["home"].length.to_f) * 100).ceil(2)
  end
end
