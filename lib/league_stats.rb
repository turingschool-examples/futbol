require 'csv'
require 'stat_tracker'
require 'calculable'

class LeagueStats
  include Calculable

  def initialize(data)
    @games = data.games
    @teams = data.teams
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    id_team_key.find do |id, team|
      return team if id == goals_per_game.max_by {|id, goals| goals}.first
    end
  end

  def worst_offense
    id_team_key.find do |id, team|
      return team if id == goals_per_game.min_by {|id, goals| goals}.first
    end
  end

  def highest_scoring_visitor
    id_team_key.find do |id, team|
      return team if id == highest_goals_per_game_place(:away_team_id, :away_goals)
    end
  end

  def highest_scoring_home_team
    id_team_key.find do |id, team|
      return team if id == highest_goals_per_game_place(:home_team_id, :home_goals)
    end
  end

  def lowest_scoring_visitor
    id_team_key.find do |id, team|
      return team if id == lowest_goals_per_game_place(:away_team_id, :away_goals)
    end
  end

  def lowest_scoring_home_team
    id_team_key.find do |id, team|
      return team if id == lowest_goals_per_game_place(:home_team_id, :home_goals)
    end
  end

  private

  def games_by_id(place_team_id)
    number_played = Hash.new(0)
    @games.each do |game|
      number_played[game[place_team_id]] += 1 if game[place_team_id]
    end
    number_played
  end

  def total_games
    module_sum(games_by_id(:home_team_id), games_by_id(:away_team_id))
  end
 
  def goals_by_id(place_team_id, place_goals)
    goals_scored = Hash.new(0)
    @games.each do |game|
      goals_scored[game[place_team_id]] += game[place_goals].to_i
    end
    goals_scored
  end

  def total_goals
    module_sum(goals_by_id(:home_team_id, :home_goals), goals_by_id(:away_team_id,:away_goals))
  end

  def goals_per_game
    module_ratio(total_goals, total_games)
  end

  def highest_goals_per_game_place(place_team_id, place_goals)
    goal_rate = module_ratio(goals_by_id(place_team_id, place_goals), games_by_id(place_team_id))
    module_highest(goal_rate)
  end

  def lowest_goals_per_game_place(place_team_id, place_goals)
     goal_rate = module_ratio(goals_by_id(place_team_id, place_goals), games_by_id(place_team_id))
     module_lowest(goal_rate)
   end
end