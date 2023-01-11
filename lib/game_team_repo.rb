require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameTeamRepo
  attr_reader :game_teams,
              :teams

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
    @teams = Team.read_file(locations[:teams])
  end

  def average_goals_team
    total_goals_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_goals_by_team[game_team.team_id] = [game_team.goals.to_i]
    end
    total_goals_by_team 

    avg_goals_by_team = Hash.new(0)
    total_goals_by_team.each do |id, total_goals|
      total_goals.each do |total_goal|
       avg_goals_by_team[id] = (total_goal.to_f / @game_teams.find_all { |game| game.team_id == id }.length.to_f).round(2)
      end
    end
    avg_goals_by_team
  end

  def highest_avg_goals_by_team
    average_goals_team.max_by do |game, goals|
      goals
    end.first
  end

  def lowest_avg_goals_by_team
    average_goals_team.min_by do |game, goals|
      goals
    end.first
  end

  def highest_scoring_visitor
    team_total_goals = Hash.new (0)
    @game_teams.each do |game|
        (team_total_goals[game.team_id] += game.goals.to_i) if game.hoa == "away" 
    end
    
    team_total_goals.update(team_total_goals) do |team_id, away_games|
        team_total_goals[team_id].to_f / @game_teams.find_all { |game| game.hoa == "away" && game.team_id == team_id}.length
    end
    
    highest_away_team_id = team_total_goals.key(team_total_goals.values.max)
    
    highest_away_team = @teams.find { |team| team.team_name if team.team_id == highest_away_team_id }
    highest_away_team.team_name
  end

  def highest_scoring_home_team
    team_total_goals = Hash.new (0)
    @game_teams.each do |game|
        (team_total_goals[game.team_id] += game.goals.to_i) if game.hoa == "home" 
    end
    
    team_total_goals.update(team_total_goals) do |team_id, away_games|
        team_total_goals[team_id].to_f / @game_teams.find_all { |game| game.hoa == "home" && game.team_id == team_id}.length
    end
    
    highest_home_team_id = team_total_goals.key(team_total_goals.values.max)
    
    highest_home_team = @teams.find { |team| team.team_name if team.team_id == highest_home_team_id }
    highest_home_team.team_name
  end

  def lowest_scoring_visitor
    team_total_goals = Hash.new (0)
    @game_teams.each do |game|
        (team_total_goals[game.team_id] += game.goals.to_i) if game.hoa == "away" 
    end
    
    team_total_goals.update(team_total_goals) do |team_id, away_games|
        team_total_goals[team_id].to_f / @game_teams.find_all { |game| game.hoa == "away" && game.team_id == team_id}.length
    end
    
    highest_away_team_id = team_total_goals.key(team_total_goals.values.min)
    
    highest_away_team = @teams.find { |team| team.team_name if team.team_id == highest_away_team_id }
    highest_away_team.team_name
  end

  def lowest_scoring_home_team
    team_total_goals = Hash.new (0)
    @game_teams.each do |game|
        (team_total_goals[game.team_id] += game.goals.to_i) if game.hoa == "home" 
    end
    
    team_total_goals.update(team_total_goals) do |team_id, away_games|
        team_total_goals[team_id].to_f / @game_teams.find_all { |game| game.hoa == "home" && game.team_id == team_id}.length
    end
    
    highest_home_team_id = team_total_goals.key(team_total_goals.values.min)
    
    highest_home_team = @teams.find { |team| team.team_name if team.team_id == highest_home_team_id }
    highest_home_team.team_name
  end

  # def winningest_coach(season_id)
  #   games_by_coach = Hash.new(0)
  #   @game_teams.count do |game_team|
  #     if game_team.game_id.slice(0..3) == season_id.slice(0..3)
  #       games_by_coach[game_team.head_coach] += 1.0
  #     end
  #   end
  #   coach_total_wins = Hash.new(0)
  #   @game_teams.count do |game_team|
  #     if game_team.result == "WIN" && game_team.game_id.slice(0..3) == season_id.slice(0..3)
  #       coach_total_wins[game_team.head_coach] += 1.0
  #     end
  #   end
  #   coach_total_wins.merge!(games_by_coach) do |coach, wins, games| 
  #     wins / games 
  #   end
  #   coach_total_wins.key(coach_total_wins.values.max)
  # end

  # def worst_coach(season_id)
  #   games_by_coach = Hash.new(0)
  #   @game_teams.count do |game_team|
  #     if game_team.game_id.slice(0..3) == season_id.slice(0..3)
  #       games_by_coach[game_team.head_coach] += 1.0
  #     end
  #   end
  #   coach_total_wins = Hash.new(0)
  #   @game_teams.count do |game_team|
  #     if game_team.result == "WIN" && game_team.game_id.slice(0..3) == season_id.slice(0..3)
  #       coach_total_wins[game_team.head_coach] += 1.0
  #     end
  #   end
  #   coach_total_wins.merge!(games_by_coach) do |coach, wins, games| 
  #     wins / games 
  #   end
  #   coach_total_wins.key(coach_total_wins.values.min)
  # end

  def most_accurate_team(season)
    accuracy = {}

    season_games = @game_teams.select { |game| game.game_id[0..3] == season[0..3] }

    season_team_ids = season_games.group_by { |season_game| season_game.team_id }.keys

    season_teams = season_team_ids.map do |team_id|
      @teams.find do |team|
        team.team_id == team_id
      end.team_name
    end

    season_team_ids.each do |season_team_id|
      team_season_games = season_games.select { |season_game| season_game.team_id == season_team_id }
      team_season_goals = team_season_games.sum { |team_season_game| team_season_game.goals.to_i }
      team_season_shots = team_season_games.sum { |team_season_game| team_season_game.shots.to_i }
      accuracy[season_team_id] = team_season_goals / team_season_shots.to_f
    end

    best_team = accuracy.max_by { |team| team[1] }[0]
    @teams.find { |team| team.team_id == best_team }.team_name
  end

  def least_accurate_team(season)
    accuracy = {}

    season_games = @game_teams.select { |game| game.game_id[0..3] == season[0..3] }

    season_team_ids = season_games.group_by { |season_game| season_game.team_id }.keys

    season_teams = season_team_ids.map do |team_id|
      @teams.find do |team|
        team.team_id == team_id
      end.team_name
    end

    season_team_ids.each do |season_team_id|
      team_season_games = season_games.select { |season_game| season_game.team_id == season_team_id }
      team_season_goals = team_season_games.sum { |team_season_game| team_season_game.goals.to_i }
      team_season_shots = team_season_games.sum { |team_season_game| team_season_game.shots.to_i }
      accuracy[season_team_id] = team_season_goals / team_season_shots.to_f
    end

    best_team = accuracy.min_by { |team| team[1] }[0]
    @teams.find { |team| team.team_id == best_team }.team_name
  end

end