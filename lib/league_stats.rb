require_relative 'stats'

class LeagueStats < Stats 
  
  def initialize(files)
    super
  end

  def count_of_teams
    @teams.count
  end

  def best_offense
    @teams.each do |team|
      if team.team_id == average_goal_by_game.key(average_goal_by_game.values.max)
        return team.team_name
      end
    end
  end

  def total_goals_by_team
    total_goals_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_goals_by_team[game_team.team_id] += game_team.goals.to_i
    end
    total_goals_by_team
  end

  def total_games_by_team
    total_games_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_games_by_team[game_team.team_id] += 1
    end
    total_games_by_team
  end

  def average_goal_by_game
    total_goals_by_team.merge!(total_games_by_team) do |team_id, goals, games|
      goals.to_f / games
    end
  end

  def worst_offense
    @teams.each do |team|
      if team.team_id == average_goal_by_game.key(average_goal_by_game.values.min)
        return team.team_name
      end
    end
  end

  def highest_scoring_visitor
    @teams.each do |team|
      if team.team_id == average_goal_by_away_team.key(average_goal_by_away_team.values.max)
        return team.team_name
      end
    end
  end
  
  def total_goals_by_away_team
    total_goals_by_away_team = Hash.new(0)
    @games.each do |game|
      total_goals_by_away_team[game.away_team_id] += game.away_goals.to_i
    end
    total_goals_by_away_team
  end

  def total_away_games_by_team
    total_away_games_by_team = Hash.new(0)
     @games.each do |game|
      total_away_games_by_team[game.away_team_id] += 1 
    end
    total_away_games_by_team
  end

  def average_goal_by_away_team
    total_goals_by_away_team.merge!(total_away_games_by_team) do |away_team_id, away_goals, away_games|
      away_goals.to_f / away_games
    end
  end
  
  def highest_scoring_home_team
    @teams.each do |team|
      if team.team_id == average_goal_by_home.key(average_goal_by_home.values.max)
        return team.team_name
      end
    end
  end

  def total_goals_by_home_team
    total_goals_by_home_team = Hash.new(0)
    @games.each do |game|
      total_goals_by_home_team[game.home_team_id] += game.home_goals.to_i
    end
    total_goals_by_home_team
  end

  def total_home_games_by_team
    total_home_games_by_team = Hash.new(0)
    @games.each do |game|
      total_home_games_by_team[game.home_team_id] += 1 
    end
    total_home_games_by_team
  end

  def average_goal_by_home
    total_goals_by_home_team.merge!(total_home_games_by_team) do |home_team_id, home_goals, home_games|
      home_goals.to_f / home_games
    end
  end

  def lowest_scoring_visitor
    @teams.each do |team|
      if team.team_id == average_goal_by_away_team.key(average_goal_by_away_team.values.min)
        return team.team_name
      end
    end
  end

  def lowest_scoring_home_team
    @teams.each do |team|
      if team.team_id == average_goal_by_home.key(average_goal_by_home.values.min)
        return team.team_name
      end
    end
  end  
end