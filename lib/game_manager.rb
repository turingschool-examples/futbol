require './lib/game'

class GameManager

  attr_reader :games_array

  def initialize(game_path)
    @games_array = []
    CSV.foreach(game_path, headers: true) do |row|
      @games_array << Game.new(row)
    end
  end

  def highest_total_score
    @all_goals_max = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_max << total_goals
    end
    @all_goals_max.max
  end

  def lowest_total_score
    @all_goals_min = []
    @games_array.each do |game|
      total_goals = game.away_goals.to_i + game.home_goals.to_i
      @all_goals_min << total_goals
    end
    @all_goals_min.min
  end

  def create_games_by_season_array
    games_by_season = {}
    @games_array.each do |game|
      games_by_season[game.season] = []
    end
    @games_array.each do |game|
      games_by_season[game.season]<< game.game_id
    end
    games_by_season
  end

  def count_of_games_by_season(games_by_season)
    games_by_season.each { |k, v| games_by_season[k] = v.count}
  end

# def away_team_average_goals(away_team_id)
#     away_teams_by_id = @games.find_all do |game|
#       game.away_team_id.to_i == away_team_id
#    end

#     total_away_goals = away_teams_by_id.sum do |away_teams|
#       away_teams.away_goals.to_i
#     end
#     (total_away_goals.to_f / away_teams_by_id.size).round(2)
#   end

#     def away_teams_sort_by_average_goal
#       Games.all.sort_by do |game|
#         away_team_average_goals(game.away_team_id.to_i)
#       end
#     end


  end
