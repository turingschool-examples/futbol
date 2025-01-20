require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_factory'
require_relative './team_factory'
require_relative './game_team_factory'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(filepaths_hash)
    games = GameFactory.create_games(filepaths_hash[:games])
    teams = TeamFactory.create_teams(filepaths_hash[:teams])
    game_teams = GameTeamFactory.create_game_teams(filepaths_hash[:game_teams])

    return StatTracker.new(games, teams, game_teams)
  end

  # Game Statistics

  def highest_total_score
    highest_game = @games.max_by {|game| game.away_goals + game.home_goals}
    return (highest_game.away_goals + highest_game.home_goals)
  end

  def lowest_total_score
    lowest_game = @games.min_by {|game| game.away_goals + game.home_goals}
    return (lowest_game.away_goals + lowest_game.home_goals)
  end

  def percentage_home_wins
    home_wins = @game_teams.find_all { |game| (game.hoa == "home") && (game.result == "WIN")}.count.to_f
    home_games = @game_teams.find_all { |game| game.hoa == "home"}.count.to_f
    return (home_wins / home_games).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_teams.find_all { |game| (game.hoa == "away") && (game.result == "WIN")}.count.to_f
    visitor_games = @game_teams.find_all { |game| game.hoa == "away"}.count.to_f
    return (visitor_wins / visitor_games).round(2)
  end

  def percentage_ties
    games_tied = @game_teams.find_all { |game| game.result == "TIE"}.count.to_f
    total_games = @game_teams.count.to_f
    return (games_tied / total_games).round(2)    
  end

  def count_of_games_by_season
    seasons_count = Hash.new(0)
    @games.each{|game| seasons_count[game.season] += 1}
    return seasons_count
  end

  def average_goals_per_game
    total_goals = @games.sum{|game| game.away_goals + game.home_goals}
    (total_goals.to_f/@games.count).round(2)
  end

  def average_goals_by_season
    average_goals = Hash.new(0)
    total = Hash.new(0)
    @games.each do |game| 
      season = game.season
      total[season] += (game.away_goals + game.home_goals)
      average_goals[season] = (total[season].to_f / count_of_games_by_season[season].to_f).round(2)
    end
    return average_goals
  end
  
  # League Statistics
   
  def count_of_teams
    @teams.count
  end

  def best_offense
    team_scores = Hash.new(0)
    team_games = Hash.new(0)

    @games.each do |game|
      home_id = game.home_team_id
      away_id = game.away_team_id

      team_scores[home_id] += game.home_goals
      team_scores[away_id] += game.away_goals

      team_games[home_id] += 1
      team_games[away_id] += 1
    end

    avg_scores = {}
    team_scores.each do |team_id, points|
      avg_scores[team_id] = points.to_f / team_games[team_id]
    end

    highest_avg_score = avg_scores.values.max

    highest_scoring_team_id = avg_scores.key(highest_avg_score)
    
    @teams.find {|team| team.team_id == highest_scoring_team_id}.team_name
  end

  def worst_offense
    team_scores = Hash.new(0)
    team_games = Hash.new(0)

    @games.each do |game|
      home_id = game.home_team_id
      away_id = game.away_team_id

      team_scores[home_id] += game.home_goals
      team_scores[away_id] += game.away_goals

      team_games[home_id] += 1
      team_games[away_id] += 1
    end

    avg_scores = {}
    team_scores.each do |team_id, points|
      avg_scores[team_id] = points.to_f / team_games[team_id]
    end

    lowest_avg_score = avg_scores.values.min

    lowest_scoring_team_id = avg_scores.key(lowest_avg_score)
    
    @teams.find {|team| team.team_id == lowest_scoring_team_id}.team_name
  end

  def away_average_score
    away_scores = Hash.new(0)
    away_count = Hash.new(0)

    @games.each do |game| 
      away_scores[game.away_team_id] += game.away_goals
      away_count[game.away_team_id] += 1
    end
    away_scores.each{|team_id, goals| away_scores[team_id] = (goals.to_f / away_count[team_id]).round(2)}
    return away_scores
  end

  def home_average_score
    home_scores = Hash.new(0)
    home_count = Hash.new(0)
    @games.each do |game|  
      home_scores[game.home_team_id] += game.home_goals
      home_count[game.home_team_id] += 1
    end
    home_scores.each{|team_id, goals| home_scores[team_id] = (goals.to_f / home_count[team_id]).round(2)}
    return home_scores
  end

  def team_name(team_id)
    team = @teams.find{|team| team.team_id == team_id.to_s}
    team.team_name
  end

  def highest_scoring_visitor
    sorted = away_average_score.max_by{|key, value| value}
    team_name(sorted[0])
  end

  def highest_scoring_home_team
    sorted = home_average_score.max_by{|key, value| value}
    team_name(sorted[0]) 
  end

  def lowest_scoring_visitor
    lowest_away_scorer = away_average_score.min_by { |team_id, score| score }
    team_name(lowest_away_scorer[0])
  end
    
  def lowest_scoring_home_team
    lowest_home_scorer = home_average_score.min_by { |team_id, score| score }
    team_name(lowest_home_scorer[0])
  end

  def team_info(team_id)
    team_object = @teams.find { |team| team.team_id == team_id }
    team_info = {
      "team_id" => team_object.team_id, 
      "franchise_id" => team_object.franchise_id, 
      "team_name" => team_object.team_name, 
      "abbreviation" => team_object.abbreviation, 
      "link" => team_object.link
    }
    return team_info
  end
  
  def best_season(team_id)
    team_games = @game_teams.find_all {|game_team| game_team.team_id == team_id}

    team_games_by_season = team_games.group_by {|game_team| game_team_season(game_team)}

    season_win_percentages = Hash.new(0)

    team_games_by_season.each do |season, game_teams|
      season_wins = game_teams.find_all {|game_team| game_team.result == "WIN"}.count
      season_games = game_teams.count
      season_win_percentage = (season_wins.to_f / season_games.to_f)
      season_win_percentages[season] = season_win_percentage
    end

    best_season = season_win_percentages.max_by { |season, win_percentage| win_percentage}.first
    return best_season
  end

  def worst_season(team_id)
    team_games = @game_teams.find_all {|game_team| game_team.team_id == team_id}

    team_games_by_season = team_games.group_by {|game_team| game_team_season(game_team)}

    season_win_percentages = Hash.new(0)

    team_games_by_season.each do |season, game_teams|
      season_wins = game_teams.find_all {|game_team| game_team.result == "WIN"}.count
      season_games = game_teams.count
      season_win_percentage = (season_wins.to_f / season_games.to_f)
      season_win_percentages[season] = season_win_percentage
    end

    worst_season = season_win_percentages.min_by { |season, win_percentage| win_percentage}.first
    return worst_season
  end
  
  def average_win_percentage(team_id)
   team_games = @game_teams.find_all {|game| game.team_id == team_id }
   games_played = team_games.count
   games_won = team_games.find_all { |game_team| game_team.result == "WIN" }.count
   games_won = 0 if !games_won 
   average_win_percentage = (games_won.to_f / games_played.to_f).round(2)
   return average_win_percentage
  end
  
  def most_goals_scored(team_id) 
    max_goals = 0

    @games.each do |game|
      if game.home_team_id == team_id
        max_goals = game.home_goals if game.home_goals > max_goals
      elsif game.away_team_id == team_id
        max_goals = game.away_goals if game.away_goals > max_goals
      end
    end

    max_goals
  end

  def fewest_goals_scored(team_id)
    fewest_goals = 0

    @games.each do |game|
      if game.home_team_id == team_id
        fewest_goals = game.home_goals if game.home_goals < fewest_goals
      elsif game.away_team_id == team_id
        fewest_goals = game.away_goals if game.away_goals < fewest_goals
      end
    end

    fewest_goals
  end
  
  def favorite_opponent(team_id)
    team_wins = Hash.new(0)
    team_matches = Hash.new(0)
    
    @games.each do |game| 
      if game.away_team_id == team_id

        if game.away_goals > game.home_goals
          team_wins[game.home_team_id] += 1
        end

        team_matches[game.home_team_id] += 1

      elsif game.home_team_id == team_id

        if game.home_goals > game.away_goals
          team_wins[game.away_team_id] += 1
        end

        team_matches[game.away_team_id] += 1
      end
    end

    team_win_percentages = Hash.new(0)

    team_wins.each do |team, wins|
      team_win_percentages[team] = (wins.to_f/team_matches[team].to_f).round(2)
    end

    return team_name(team_win_percentages.max_by {|team, win_percentage| win_percentage}.first)
  end


  def rival(team_id)
    team_wins = Hash.new(0)
    team_matches = Hash.new(0)
    
    @games.each do |game| 
      if game.away_team_id == team_id

        if game.away_goals > game.home_goals
          team_wins[game.home_team_id] += 1
        end

        team_matches[game.home_team_id] += 1

      elsif game.home_team_id == team_id

        if game.home_goals > game.away_goals
          team_wins[game.away_team_id] += 1
        end

        team_matches[game.away_team_id] += 1
      end
    end

    team_win_percentages = Hash.new(0)

    team_wins.each do |team, wins|
      team_win_percentages[team] = (wins.to_f/team_matches[team].to_f).round(2)
    end

    return team_name(team_win_percentages.min_by {|team, win_percentage| win_percentage}.first)
  end


  # Season Stats

  def winningest_coach(season)
    games_coached = @game_teams.group_by { |game| game.head_coach}

    games_coached_by_season = Hash.new(0)
    
    games_coached.each { |coach, game_teams|
    games_coached_by_season[coach] = game_teams.find_all {|game_team| game_team_season(game_team) == season} 
  }
  
    coach_stats = {}
    winningest_coach = nil

    games_coached_by_season.each do |coach, games|
      total_games = games.count
      next if total_games <= 1
      wins = games.count { |game| game.result == "WIN" }
      win_percentage = (wins.to_f / total_games.to_f).round(2)
      coach_stats[coach] = win_percentage
      winningest_coach = coach_stats.max_by { |coach, win_percentage| win_percentage }.first
    end
    return winningest_coach
  end

  def worst_coach(season)
    games_coached = @game_teams.group_by { |game| game.head_coach}

    games_coached_by_season = Hash.new(0)

    games_coached.each { |coach, game_teams|
      games_coached_by_season[coach] = game_teams.find_all {|game_team| game_team_season(game_team) == season} 
    }

    coach_stats = {}
    worst_coach = nil

    games_coached_by_season.each do |coach, games|
      total_games = games.count
      next if total_games <= 1
      wins = games.count { |game| game.result == "WIN" }
      win_percentage = (wins.to_f / total_games.to_f).round(2)
      coach_stats[coach] = win_percentage
      worst_coach = coach_stats.min_by { |coach, win_percentage| win_percentage }.first
    end
    return worst_coach
  end

  def game_team_season(game_team)
    game_team_id = game_team.game_id
    corresponding_game = @games.find {|game| game.game_id == game_team_id}
    return corresponding_game.season
  end

  def most_accurate_team(season)
    games_played = @game_teams.group_by { |game| game.team_id}

    games_played_by_season = Hash.new(0)

    games_played.each { |team, game_teams|
      games_played_by_season[team] = game_teams.find_all {|game_team| game_team_season(game_team) == season} 
    }
    team_percentage = {}
    games_played_by_season.each do |team, games|
      total_goals = games.sum {|game| game.goals}
      total_shots = games.sum {|game| game.shots}
      next if total_shots < 1
      goals_to_shots = (total_goals.to_f / total_shots.to_f).round(2)
      team_percentage[team] = goals_to_shots 
    end
    best_team = team_percentage.max_by { |team, goals_to_shots| goals_to_shots}.first
    return team_name(best_team)
    
  end

  def least_accurate_team(season)
    games_played = @game_teams.group_by { |game| game.team_id}

    games_played_by_season = Hash.new(0)

    games_played.each { |team, game_teams|
      games_played_by_season[team] = game_teams.find_all {|game_team| game_team_season(game_team) == season} 
    }
    team_percentage = {}
    games_played_by_season.each do |team, games|
      total_goals = games.sum {|game| game.goals}
      total_shots = games.sum {|game| game.shots}
      next if total_shots < 1
      goals_to_shots = (total_goals.to_f / total_shots.to_f).round(3)
      team_percentage[team] = goals_to_shots 
    end
    worst_team = team_percentage.min_by { |team, goals_to_shots| goals_to_shots}.first
    return team_name(worst_team)
  end

  def most_tackles(season)
    season_games = @games.select { |game| game.season == season }
    season_game_teams = []
    teams_hash = {}

    season_games.each do |game|
      matching_game_teams = @game_teams.select { |game_team| game_team.game_id == game.game_id}
      season_game_teams += matching_game_teams
    end

    season_game_teams.each do |season_game|
      team_id = season_game.team_id.to_sym
      if not teams_hash.has_key? team_id
        teams_hash[team_id] = 0
      end
      teams_hash[team_id] += season_game.tackles.to_i
    end

    most_tackles = teams_hash.values.max
    most_tackles_team_id = teams_hash.key(most_tackles).to_s
    @teams.find { |team| team.team_id == most_tackles_team_id }.team_name
  end

  def fewest_tackles(season)
    season_games = @games.select { |game| game.season == season }
    season_game_teams = []
    teams_hash = {}

    season_games.each do |game|
      matching_game_teams = @game_teams.select { |game_team| game_team.game_id == game.game_id}
      season_game_teams += matching_game_teams
    end

    season_game_teams.each do |season_game|
      team_id = season_game.team_id.to_sym
      if not teams_hash.has_key? team_id
        teams_hash[team_id] = 0
      end
      teams_hash[team_id] += season_game.tackles.to_i
    end

    fewest_tackles = teams_hash.values.min
    fewest_tackles_team_id = teams_hash.key(fewest_tackles).to_s
    @teams.find { |team| team.team_id == fewest_tackles_team_id }.team_name
  end

end