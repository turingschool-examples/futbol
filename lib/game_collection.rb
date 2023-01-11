require 'csv'
require_relative '../lib/game'

class GameCollection
  attr_reader :games_array

  def initialize(location)
    @games_array = []
	  CSV.foreach(location, headers: true, header_converters: :symbol) do |row|
	    @games_array << Game.new(row)
	  end
	end

  def total_score
    total_score = @games_array.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
	end
  end

  def add_total_away_score_and_away_games(teams_total_scores, teams_total_games)
    # find_average(@game_teams_array, teams_total_scores, teams_total_games, team_id, goals)

    @games_array.each do |game|
      teams_total_scores[game.away_team_id] += game.away_goals.to_f
      teams_total_games[game.away_team_id] += 1.0
    end
  end

  def add_total_home_score_and_home_games(teams_total_scores, teams_total_games)
    # find_average(@game_teams_array, teams_total_scores, teams_total_games, team_id, goals)

    @games_array.each do |game|
      teams_total_scores[game.home_team_id] += game.home_goals.to_f
      teams_total_games[game.home_team_id] += 1.0
    end
  end

end