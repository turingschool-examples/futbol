require_relative './stat_data'

class LeagueStats < StatData

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    teams = []
    @games.each do |row|
      teams.push([row[:home_team_id], row[:home_goals]])
      teams.push([row[:away_team_id], row[:away_goals]])
    end

    hash = Hash.new {|hash, key| hash[key] = []}
    teams.each do |array|
      hash[array[0]] << array[1].to_i
    end

    hash.each do |k, v|
      if v.size > 1
        hash[k] = v.sum.to_f/v.size
      else
        hash[k] = v[0].to_f/1
      end
    end

    max_team = hash.max_by do |k, v|
      v
    end

    best_offense = nil
    @teams.each do |team|
      best_offense = team[:teamname] if team[:team_id] == max_team[0]
    end
    best_offense
  end

  def worst_offense
    teams = []
    @games.each do |row|
      teams.push([row[:home_team_id], row[:home_goals]])
      teams.push([row[:away_team_id], row[:away_goals]])
    end

    hash = Hash.new {|hash, key| hash[key] = []}
    teams.each do |array|
      hash[array[0]] << array[1].to_i
    end

    hash.each do |k, v|
      if v.size > 1
        hash[k] = v.sum.to_f/v.size
      else
        hash[k] = v[0].to_f/1
      end
    end

    min_team = hash.min_by do |k, v|
      v
    end

    worst_offense = nil
    @teams.each do |team|
      worst_offense = team[:teamname] if team[:team_id] == min_team[0]
    end
    worst_offense
  end
  
  
  def away_goals_by_team_id
    away_goals = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "away"
        away_goals[row[:team_id]] += row[:goals].to_i
      end 
    end
    away_goals 
  end

  def away_games_by_team_id
    away_games = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "away"
        away_games[row[:team_id]] += 1
      end
    end
    away_games
  end

  def home_goals_by_team_id
    home_goals = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "home"
        home_goals[row[:team_id]] += row[:goals].to_i
      end
      
    end
    home_goals 
  end

  def home_games_by_team_id
    home_games = Hash.new(0)
    @game_teams.each do |row|
      if row[:hoa] == "home"
        home_games[row[:team_id]] += 1
      end
      
    end
    home_games
  end

  def away_goal_avg_per_game
    hash = Hash.new(0)
    away_games_by_team_id.each do |teams1, games|
      away_goals_by_team_id.each do |teams2, goals|
        if teams1 == teams2
          hash[teams1] = (goals / games.to_f).round(2)
        end
      end
    end
    hash
  end

  def home_goal_avg_per_game
    hash = Hash.new(0)
    home_games_by_team_id.each do |teams1, games|
      home_goals_by_team_id.each do |teams2, goals|
        if teams1 == teams2
          hash[teams1] = (goals / games.to_f).round(2)
        end
      end
    end
    hash
  end

  def highest_scoring_visitor
    highest_visitor = away_goal_avg_per_game.max_by {|k, v| v}
    best_away_team = nil
    @teams.each do |team|
      if highest_visitor.first == team[:team_id]
        best_away_team = team[:teamname]
      end
    end
    best_away_team
  end

  def lowest_scoring_visitor
    highest_visitor = away_goal_avg_per_game.min_by {|k, v| v}
    best_away_team = nil
    @teams.each do |team|
      if highest_visitor.first == team[:team_id]
        best_away_team = team[:teamname]
      end
    end
    best_away_team
  end

  def highest_scoring_home_team
    highest_home_team = home_goal_avg_per_game.max_by {|k, v| v}
    best_home_team = nil
    @teams.each do |team|
      if highest_home_team.first == team[:team_id]
        best_home_team = team[:teamname]
      end
    end
    best_home_team
  end

  def lowest_scoring_home_team
    lowest_home_team = home_goal_avg_per_game.min_by {|k, v| v}
    best_home_team = nil
    @teams.each do |team|
      if lowest_home_team.first == team[:team_id]
        best_home_team = team[:teamname]
      end
    end
    best_home_team
  end
end
