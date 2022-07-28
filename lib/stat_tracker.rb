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

  def winningest_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| percentage}.first
  end

  def worst_coach(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    coaches_and_results= game_teams.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
      wins[coach] += 0
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end

    win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  def most_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_highest_accuracy = team_id_accuracy.max_by{|team, acc| acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_highest_accuracy]

  end

  def least_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_lowest_accuracy = team_id_accuracy.max_by{|team, acc| -acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_lowest_accuracy]
  end

  def most_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    most_tackles = id_tackles.max_by{|id, tackles| tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[most_tackles]
  end

  def fewest_tackles(target_season)
    games = @games.to_a.select do |game|
              game[1] == target_season
            end
    game_ids = games.map do |game|
                game[0]
               end
    game_teams = @game_teams.select do |game_team|
                    game_ids.include?(game_team[:game_id])
                  end
    id_tackles = Hash.new(0)
    game_teams.each do |game|
      id_tackles[game[:team_id]] += game[:tackles].to_i
    end

    fewest_tackles = id_tackles.max_by{|id, tackles| -tackles}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[fewest_tackles]


  end

  def count_of_teams
    @teams.count
  end

  def id_team_hash
    @id_and_team = {}

    @teams.each do |team|
      @id_and_team[team[:team_id]] = team[:teamname]
    end
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
        elsif game[:away_team_id] == id
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
        elsif game[:away_team_id] == id
          goals[:name] = team_name
          goals[:away_goals] += game[:away_goals].to_i
        end
      end
      @goals_scored[id] = goals
    end
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
    total_goals; h1 = @total_goals_by_team
    total_games; h2 = @total_games_by_team

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    best = new_hash.sort_by do |id, ratio|
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
    total_goals; h1 = @total_goals_by_team
    total_games; h2 = @total_games_by_team
    
    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    worst = new_hash.sort_by do |team_id, ratio|
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

    h1 = {}
    h2 = {}

    @goals_scored.each do |id, goal_info|
      h1[id] = goal_info[:away_goals]
    end

    @number_played.each do |id, game_info|
      h2[id] = game_info[:away_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    best_vis = new_hash.sort_by do |id, ratio|
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

    h1 = {}
    h2 = {}

    @goals_scored.each do |id, goal_info|
      h1[id] = goal_info[:home_goals]
    end

    @number_played.each do |id, game_info|
      h2[id] = game_info[:home_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    best_home = new_hash.sort_by do |id, ratio|
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

    h1 = {}
    h2 = {}

    @goals_scored.each do |id, goal_info|
      h1[id] = goal_info[:away_goals]
    end

    @number_played.each do |id, game_info|
      h2[id] = game_info[:away_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    worst_vis = new_hash.sort_by do |id, ratio|
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

    h1 = {}
    h2 = {}

    @goals_scored.each do |id, goal_info|
      h1[id] = goal_info[:home_goals]
    end

    @number_played.each do |id, game_info|
      h2[id] = game_info[:home_games]
    end

    new_hash = h1.merge(h2) do |key, goals, games| 
      goals.to_f / games
    end

    worst_home = new_hash.sort_by do |id, ratio|
      ratio
    end

    @id_and_team.find do |id, team|
      if id == worst_home[0][0]
        return team[:name]
      end
    end
  end
end
