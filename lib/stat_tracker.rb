require 'csv'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end

  def count_of_teams
    @teams.count
  end

  def id_team_hash
    @id_and_team = {}

    @teams.each do |team|
      @id_and_team[team[:team_id]] = team[:teamname]
    end
    @id_and_team
  end

  def number_of_games_played
    id_team_hash
    @number_played = @id_and_team

   @number_played.each do |id, team_name|
      games_played = Hash.new{0}

      @games.each do |game|
        if game[:home_team_id] == id
          games_played[:name] = team_name
          games_played[:home_games] += 1
        end
        if game[:away_team_id] == id
          games_played[:name] = team_name
          games_played[:away_games] += 1
        end
      end
      @number_played[id] = games_played
    end
  end

  def total_games
    number_of_games_played
    @number_played
    @total_games_by_team = {}

    @number_played.each do |id, team_game|
      @total_games_by_team[id] = (team_game[:home_games] + team_game[:away_games])
    end
  end

  def goals_by_id
    id_team_hash
    @goals_scored = @id_and_team

    @goals_scored.each do |id, team_name|
      goals = Hash.new{0}

      @games.each do |game|
        if game[:home_team_id] == id
          goals[:name] = team_name
          goals[:home_goals] += game[:home_goals].to_i
        end
        if game[:away_team_id] == id
          goals[:name] = team_name
          goals[:away_goals] += game[:away_goals].to_i
        end
      end
      @goals_scored[id] = goals
    end
    @goals_scored
  end

  def total_goals
    goals_by_id
    @goals_scored
    @total_goals_by_team = {}

    @goals_scored.each do |id, team_goals|
      @total_goals_by_team[id] = (team_goals[:home_goals] + team_goals[:away_goals])
    end
  end

  def best_offense
    id_team_hash; @id_and_team
    total_goals; @total_goals_by_team
    total_games; @total_games_by_team

     @total_goals_by_team.each do |goal_id, goals|
        @the_best = {}
        @total_games_by_team.each do |game_id, games|
          @the_best[game_id] = (goals.to_f/games).round(4)
        end
      @the_best
    end
    best = @the_best.sort_by do |id, ratio|
      ratio
    end
   @id_and_team.find do |id, team|
      if id == best[-1][0]
       return team[:name]
      end
    end
  end

  def worst_offense
    id_team_hash; @id_and_team
    total_goals; @total_goals_by_team
    total_games; @total_games_by_team

     @total_goals_by_team.each do |goal_id, goals|
        @the_worst = {}
        @total_games_by_team.each do |game_id, games|
          @the_worst[game_id] = (goals.to_f/games).round(4)
        end
      @the_worst
    end

    worst = @the_worst.sort_by do |id, ratio|
      ratio
    end

    @id_and_team.find do |id, team|
      if id == worst[0][0]
       return team[:name]
      end
    end
  end

  def highest_scoring_visitor
    id_team_hash; @id_and_team
    goals_by_id; @goals_scored
    number_of_games_played; @number_played

    @goals_scored.each do |goal_id, goal_info|
      @high_vis = {}
      @number_played.each do |game_team_id, game_info|
        @high_vis[game_team_id] = (goal_info[:away_goals].to_f / game_info[:away_games]).round(4)
      end
    end
    best_vis = @high_vis.sort_by do |id, ratio|
      ratio
    end
    @id_and_team.find do |id, team|
      if id == best_vis[-1][0]
        return team[:name]
      end
    end
  end
  
  def highest_scoring_home_team
    id_team_hash; @id_and_team
    goals_by_id; @goals_scored
    number_of_games_played; @number_played

    @goals_scored.each do |goal_id, goal_info|
      @high_home = {}
      @number_played.each do |game_team_id, game_info|
        @high_home[game_team_id] = (goal_info[:home_goals].to_f / game_info[:home_games]).round(4)
      end
    end
    best_home = @high_home.sort_by do |id, ratio|
      ratio
    end
    @id_and_team.find do |id, team|
      if id == best_home[-1][0]
        return team[:name]
      end
    end
  end

  def lowest_scoring_visitor
    id_team_hash; @id_and_team
    goals_by_id; @goals_scored
    number_of_games_played; @number_played

    @goals_scored.each do |goal_id, goal_info|
      @low_vis = {}
      @number_played.each do |game_team_id, game_info|
        @low_vis[game_team_id] = (goal_info[:away_goals].to_f / game_info[:away_games]).round(4)
      end
    end
    worst_vis = @low_vis.sort_by do |id, ratio|
      ratio
    end
    @id_and_team.find do |id, team|
      if id == worst_vis[0][0]
        return team[:name]
      end
    end

  end

  def lowest_scoring_home_team
    id_team_hash; @id_and_team
    goals_by_id; @goals_scored
    number_of_games_played; @number_played

    @goals_scored.each do |goal_id, goal_info|
      @low_home = {}
      @number_played.each do |game_team_id, game_info|
        @low_home[game_team_id] = (goal_info[:home_goals].to_f / game_info[:home_games]).round(4)
      end
    end
    worst_home = @low_home.sort_by do |id, ratio|
      ratio
    end
    @id_and_team.find do |id, team|
      if id == worst_home[0][0]
        return team[:name]
      end
    end
  end
end
