require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class GameTeamRepo
  attr_reader :game_teams,
              :teams,
              :games

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
    @teams = Team.read_file(locations[:teams])
    @games = Game.read_file(locations[:games])
  end

  def best_offense
    total_goals_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_goals_by_team[game_team.team_id] = [game_team.goals.to_i]
    end
    total_goals_by_team.keys.each do |team|
      total_goals_by_team[team] = (total_goals_by_team[team].sum.to_f / (total_goals_by_team[team].count)).round(2)
    end
    avg_goal_team_id = total_goals_by_team.max_by { |team_id, goals| goals }.first
    @teams.find { |team| team.team_name if team.team_id == avg_goal_team_id }.team_name
  end
  
  def worst_offense
    total_goals_by_team = Hash.new(0)
    @game_teams.each do |game_team|
      total_goals_by_team[game_team.team_id] = [game_team.goals.to_i]
    end
    total_goals_by_team.keys.each do |team|
      total_goals_by_team[team] = (total_goals_by_team[team].sum.to_f / (total_goals_by_team[team].size)).round(2)
    end
    avg_goal_team_id = total_goals_by_team.min_by { |team_id, goals| goals }.first
    @teams.find { |team| team.team_name if team.team_id == avg_goal_team_id }.team_name
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

  def winningest_coach(for_season) 
    game_teams = @game_teams.find_all { |game| game.game_id.to_s[0,4] == for_season[0,4] }
    games_coached = game_teams.group_by { |game| game.head_coach }
    games_coached.each do |coach, games|
      coach_win_percentage = games.count{|game| game.result == "WIN"}/games.length.to_f
      games_coached[coach] = coach_win_percentage
    end
    games_coached.key(games_coached.values.max)
  end

  def worst_coach(for_season)
    game_teams = @game_teams.find_all { |game| game.game_id.to_s[0,4] == for_season[0,4] }
    games_coached = game_teams.group_by { |game| game.head_coach }
    games_coached.each do |coach, games|
      coach_win_percentage = games.count{|game| game.result == "WIN"}/games.length.to_f
      games_coached[coach] = coach_win_percentage
    end
    games_coached.key(games_coached.values.min)
  end

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

  def most_tackles(season_id)
    season_tackles = Hash.new(0)
    season_games = @games.group_by { |game| game.season}

    game_id = season_games[season_id].map { |game| game.game_id }
   
    game_id.each do |id|
      @game_teams.each do |game_team|
        if game_team.game_id == id
          season_tackles[game_team.team_id] += game_team.tackles.to_i
        end
      end
    end

    team_with_most_tackles = season_tackles.max_by do |team_tackles|
      team_tackles[1]
    end.first
    @teams.find {|team| team.team_id == team_with_most_tackles}.team_name
  end

  def fewest_tackles(season_id)
    season_tackles = Hash.new(0)
    season_games = @games.group_by { |game| game.season}

    game_id = season_games[season_id].map { |game| game.game_id }
   
    game_id.each do |id|
      @game_teams.each do |game_team|
        if game_team.game_id == id
          season_tackles[game_team.team_id] += game_team.tackles.to_i
        end
      end
    end

    team_with_most_tackles = season_tackles.min_by do |team_tackles|
      team_tackles[1]
    end.first
    @teams.find {|team| team.team_id == team_with_most_tackles}.team_name
  end

  def average_win_percentage(team_id)
    game_teams_id = @game_teams.find_all { |team| team.team_id == team_id }
    team_results = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |game|
        team_results[game.team_id] << game.result
    end
    team_wins = team_results[team_id].select do |result|
        result == "WIN"
    end
    (team_wins.count.to_f / team_results[team_id].count.to_f).round(2)
  end

  def most_goals_scored(team_id)
    game_teams_id = @game_teams.find_all { |team| team.team_id == team_id }
    game_goals_list = []
    game_teams_id.each do |info|
        game_goals_list << info.goals
    end
    game_goals_list.max.to_i
  end

  def fewest_goals_scored(team_id)
    game_teams_id = @game_teams.find_all { |team| team.team_id == team_id }
    game_goals_list = []
    game_teams_id.each do |info|
        game_goals_list << info.goals
    end    
    game_goals_list.min.to_i
  end
end