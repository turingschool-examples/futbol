require 'csv'
require 'calculable'
require 'stat_tracker'
require 'pry'

class LeagueStats
  include Calculable

  def initialize(data)
    @games = data.games
    @teams = data.teams
    @game_teams = data.game_teams
  end

  # def home_games_by_id
    # number_played = {}
    # number_played = Hash.new(0)
    # @games.each do |game|
    #   number_played[game[:home_team_id]] += 1 if game[:home_team_id]
    # end
    # id_team_hash.each do |id, team_name|
    #   games_played = Hash.new{0}
    #   @games.each do |game|
    #     games_played[:home_games] += 1 if game[:home_team_id] == id
        #   games_played[:home_games] += 1
        # elsif game[:away_team_id] == id
        #   games_played[:away_games] += 1
      # end
      # number_played[id] = games_played
    # end
  # end

  def games_by_id(place_team_id)
    number_played = Hash.new(0)
    @games.each do |game|
      number_played[game[place_team_id]] += 1 if game[place_team_id]
    end
    number_played
  end

  def total_games
    # total_games_by_team = {}
    # number_of_games_played.each do |id, team_game|
    #   total_games_by_team[id] = (team_game[:home_games] + team_game[:away_games])
    # end
    # total_games_by_team
    games_by_id(:home_team_id).merge(:away_team_id) do |id, home_games, away_games|
      home_games + away_games
    end
    binding.pry
  end
#   def away_games_by_id
#     number_played = Hash.new(0)
#     @games.each do |game|
#       number_played[game[:away_team_id]] += 1 if game[:away_team_id]
#     end
# binding.pry
#     # id_team_hash.each do |id, team_name|
#     #   games_played = [Hash.new{0}]
#     #   @games.each do |game|
#     #     games_played[:away_games] += 1 if game[:away_team_id] == id
#     #     #   games_played[:home_games] += 1
#     #     # elsif game[:away_team_id] == id
#     #     #   games_played[:away_games] += 1
#     #   end
#     #   number_played[id] = games_played
#     # end
#   end
  
  # def number_of_games_played
  #   number_played = {}
  #   id_team_hash.each do |id, team_name|
  #     games_played = Hash.new{0}
  #     @games.each do |game|
  #       if game[:home_team_id] == id
  #         games_played[:home_games] += 1
  #       elsif game[:away_team_id] == id
  #         games_played[:away_games] += 1
  #       end
  #     end
  #     number_played[id] = games_played
  #   end
  #   number_played
  # end

  def goals_by_id(place_team_id, place_goals)
    # goals_scored = {}
    # id_team_hash.each do |id, team_name|
    #   goals = Hash.new{0}
    #   @games.each do |game|
    #     if game[:home_team_id] == id
    #       goals[:home_goals] += game[:home_goals].to_i
    #     elsif game[:away_team_id] == id
    #       goals[:away_goals] += game[:away_goals].to_i
    #     end
    #   end
    #   goals_scored[id] = goals
    # end
    # goals_scored
    # binding.pry
    goals_scored = Hash.new(0)
    @games.each do |game|
      goals_scored[game[place_team_id]] += game[place_goals].to_i
    end
    goals_scored
  end

  def total_goals
    total_goals_by_team = {}
    goals_by_id.each do |id, team_goals|
      total_goals_by_team[id] = (team_goals[:home_goals] + team_goals[:away_goals])
    end
    total_goals_by_team
  end

  def goals_per_game
    total_goals.merge(total_games) do |key, goals, games| 
      goals.to_f / games
    end
  end
  
  def count_of_teams
    @teams.count
  end

  def best_offense
    id_team_hash.find do |id, team|
      return team if id == goals_per_game.max_by {|id, goals| goals}[0]
    end
  end

  def worst_offense
    id_team_hash.find do |id, team|
      return team if id == goals_per_game.min_by {|id, goals| goals}[0]
    end
  end

  def highest_scoring_visitor
    h1 = goals_by_id(:away_team_id, :away_goals)
    h2 = games_by_id(:away_team_id)

    # goals_by_id.each do |id, goal_info|
    #   h1[id] = goal_info[:away_goals]
    # end

    # games_by_id(:away_team_id).each do |id, game_info|
    # games_by_id(:away_team_id).each do |id, game_by_id(:away_team_id).each do |id, game_info|
    #   h2[id] = game_info[:away_games]
    # end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    best_vis = new_hash.sort_by do |id, ratio|
      ratio
    end
    
    id_team_hash.find do |id, team|
      if id == best_vis[-1][0]
        return team
      end
    end
  end

  def highest_scoring_home_team

    h1 = {}
    h2 = {}

    goals_by_id.each do |id, goal_info|
      h1[id] = goal_info[:home_goals]
    end

    games_by_id(:home_team_id).each do |id, game_info|
      h2[id] = game_info[:home_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    best_home = new_hash.sort_by do |id, ratio|
      ratio
    end
    
    id_team_hash.find do |id, team|
      if id == best_home[-1][0]
        return team
      end
    end
  end

  def lowest_scoring_visitor

    h1 = {}
    h2 = {}

    goals_by_id.each do |id, goal_info|
      h1[id] = goal_info[:away_goals]
    end

    number_of_games_played.each do |id, game_info|
      h2[id] = game_info[:away_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    worst_vis = new_hash.sort_by do |id, ratio|
      ratio
    end

    id_team_hash.find do |id, team|
      if id == worst_vis[0][0]
        return team
      end
    end
  end

  def lowest_scoring_home_team

    h1 = {}
    h2 = {}

    goals_by_id.each do |id, goal_info|
      h1[id] = goal_info[:home_goals]
    end

    number_of_games_played.each do |id, game_info|
      h2[id] = game_info[:home_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    worst_home = new_hash.sort_by do |id, ratio|
      ratio
    end

    id_team_hash.find do |id, team|
      if id == worst_home[0][0]
        return team
      end
    end
  end
end