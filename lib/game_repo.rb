
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameRepo
  attr_reader :games

  def initialize(locations)
    @games = Game.read_file(locations[:games])
  end


  def game_total_score
    total_score = []
    @games.each do |game|
      total_score << game.away_goals + game.home_goals 
    end
    total_score
  end

  def highest_total_score
    game_total_score.max_by { |score| score}
  end

  def lowest_total_score
    game_total_score.min_by { |score| score}
  end

  def home_wins
    @games.count do |game|
      game.away_goals < game.home_goals
    end
  end

  def visitor_wins
    @games.count do |game|
      game.away_goals > game.home_goals
    end
  end

  def game_ties
    @games.count do |game|
      game.away_goals == game.home_goals
    end
  end

  def total_games
    @games.count 
  end
  
  def percentage(sum, total)
    (sum.to_f / total.to_f).round(2)
  end

  def percentage_home_wins
    percentage(home_wins, total_games)
  end

  def percentage_visitor_wins
    percentage(visitor_wins, total_games)
  end

  def percentage_ties
    percentage(game_ties, total_games)
  end

  def count_of_games_by_season
    games_by_season = {}
    season_games = @games.group_by { |game| game.season }

    season_games.each do |season, game|
      games_by_season[season] = game.count
    end
    games_by_season
  end

  def average_goals_per_game
    total_amount_goals = game_total_score.sum
    percentage(total_amount_goals, total_games)
  end

  def average_goals_by_season
    goals_by_season = {}
    season_goals = @games.group_by { |game| game.season }

    season_goals.map do |season, games|
      goal_sum = games.sum do |game| 
        game.away_goals + game.home_goals
      end 
      goals_by_season[season] = (goal_sum / games.count.to_f).round(2)
    end
    goals_by_season 
  end

  def best_season(team_id)
    games_list = []
    @games.each do |game|
      games_list.push(game) if game.home_team_id == team_id || game.away_team_id == team_id
      end
      games_in_a_season = games_list.group_by { |game| game.season }
      season_win_percent = Hash.new(0)
      games_in_a_season.each do |season, games|
        home_wins = games.find_all do |game|
          game.home_team_id == team_id && game.home_goals.to_i > game.away_goals.to_i
        end
        away_wins = games.find_all do |game|
          game.away_team_id == team_id && game.home_goals.to_i < game.away_goals.to_i
        end
        season_win_percent[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
    end
    season_win_percent ||= season_win_percent.team_id.to_i
    season_win_percent.key(season_win_percent.values.max_by { |percentage| percentage })
  end

  def worst_season(team_id)
    games_list = []
    @games.each do |game|
      games_list.push(game) if game.home_team_id == team_id || game.away_team_id == team_id
      end
      games_in_a_season = games_list.group_by { |game| game.season }
      season_win_percent = Hash.new(0)
      games_in_a_season.each do |season, games|
        home_wins = games.find_all do |game|
          game.home_team_id == team_id && game.home_goals.to_i > game.away_goals.to_i
        end
        away_wins = games.find_all do |game|
          game.away_team_id == team_id && game.home_goals.to_i < game.away_goals.to_i
        end
        season_win_percent[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
    end
    season_win_percent ||= season_win_percent.team_id.to_i
    season_win_percent.key(season_win_percent.values.min_by { |percentage| percentage })
  end
  
  # Use for reference on fav/rival:
  
  # def winningest_coach(for_season) 
  #   game_teams = @game_teams.find_all { |game| game.game_id.to_s[0,4] == for_season[0,4] }
  #   games_coached = game_teams.group_by { |game| game.head_coach }
  #   games_coached.each do |coach, games|
  #     coach_win_percentage = games.count{|game| game.result == "WIN"}/games.length.to_f
  #     games_coached[coach] = coach_win_percentage
  #   end
  #   games_coached.key(games_coached.values.max)
  # end

  def favorite_opponent(team_id)
    rival_games = 
  end
end