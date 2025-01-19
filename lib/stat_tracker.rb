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
    total_games = @game_teams.count.to_f
    return (home_wins / total_games) * 100.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_teams.find_all { |game| (game.hoa == "away") && (game.result == "WIN")}.count.to_f
    total_games = @game_teams.count.to_f
    return (visitor_wins / total_games) * 100.round(2)
  end

  def percentage_ties
    games_tied = @game_teams.find_all { |game| game.result == "TIE"}.count.to_f
    total_games = @game_teams.count.to_f
    return (games_tied / total_games) * 100.round(2)    
  end

  def count_of_games_by_season
    seasons_count = Hash.new(0)
    @games.each{|game| seasons_count[game.season] += 1}
    return seasons_count
    # seasons_count = Hash.new(0)
    # @games.each{|game| seasons_count[game.season] += 1}
    # return seasons_count
  end

  def average_goals_per_game
    total_goals = @games.sum{|game| game.away_goals + game.home_goals}
    (total_goals.to_f/@games.count).round(2)
    total_goals = @games.sum{|game| game.away_goals + game.home_goals}
    (total_goals.to_f/@games.count).round(2)
  end

  def average_goals_per_season
    average_goals = Hash.new(0)
    @games.each do |game| 
      season = game.season
      total = game.away_goals + game.home_goals
      average_goals[season] = (total.to_f / count_of_games_by_season[season]).round(2)
    end
    return average_goals
  end
  
  def average_goals_per_season
    average_goals = Hash.new(0)
    @games.each do |game| 
      season = game.season
      total = game.away_goals + game.home_goals
      average_goals[season] = (total.to_f / count_of_games_by_season[season]).round(2)
    end
    return average_goals
  end
  
   # League Statistics
   
  def count_of_teams
    @teams.count
  end

  def best_offense
    teams_hash = {}
    @games.each do |game|
      home_id = game.home_team_id.to_sym
      away_id = game.away_team_id.to_sym
      if !(teams_hash.has_key?(home_id))
        teams_hash[home_id] = 0
      end

      if !(teams_hash.has_key?(away_id))
        teams_hash[away_id] = 0
      end

      teams_hash[home_id] += game.home_goals.to_i
      teams_hash[away_id] += game.away_goals.to_i
    end

    highest_score = teams_hash.values.max
    highest_scoring_id = teams_hash.key(highest_score).to_s
    best_offense_team = @teams.find {|team| team.team_id == highest_scoring_id}.teamName
  end

  def worst_offense
    teams_hash = {}
    @games.each do |game|
      home_id = game.home_team_id.to_sym
      away_id = game.away_team_id.to_sym
      if !(teams_hash.has_key?(home_id))
        teams_hash[home_id] = 0
      end

      if !(teams_hash.has_key?(away_id))
        teams_hash[away_id] = 0
      end

      teams_hash[home_id] += game.home_goals.to_i
      teams_hash[away_id] += game.away_goals.to_i
    end
    lowest_score = teams_hash.values.min
    lowest_scoring_id = teams_hash.key(lowest_score).to_s
    worst_offense_team = @teams.find {|team| team.team_id == lowest_scoring_id}.teamName
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
    team = @teams.find{|x| x.team_id.include?(team_id)}
    team.teamName
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

  # Season Stats
  
  def winningest_coach(season)
    games_coached = @game_teams.group_by { |game| game.head_coach}
    coach_stats = {}
    winningest_coach = nil
    games_coached.each do |coach, games|
      total_games = games.count
      wins = games.count { |game| game.result == "WIN" }
      win_percentage = (wins.to_f / total_games.to_f).round(2)
      coach_stats[coach] = win_percentage
      winningest_coach = coach_stats.max_by { |coach, win_percentage| win_percentage }.first
    end
    return winningest_coach
  end

  def worst_coach(season)
    games_coached = @game_teams.group_by { |game| game.head_coach}
    coach_stats = {}
    worst_coach = nil
    games_coached.each do |coach, games|
      total_games = games.count
      losses = games.count { |game| game.result == "WIN" }
      loss_percentage = (losses.to_f / total_games.to_f).round(2)
      coach_stats[coach] = loss_percentage
      worst_coach = coach_stats.min_by { |coach, loss_percentage| loss_percentage }.first
    end
    return worst_coach
  end

  def most_accurate_team(season)
    season_id = []
    @games.each{|game| season_id << game.game_id if game.season == season}
    season_games = @game_teams.select {|game| season_id.include?(game.game_id) && game.goals > 0}
    max = season_games.max_by {|game| game.shots.to_f / game.goals}
    team_name(max.team_id)
  end

  def least_accurate_team(season)
    season_id = []
    @games.each{|game| season_id << game.game_id if game.season == season}
    season_games = @game_teams.select {|game| season_id.include?(game.game_id) && game.goals > 0}
    min = season_games.min_by {|game| game.shots.to_f / game.goals}
    team_name(min.team_id)
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
    most_tackles_team = @teams.find { |team| team.team_id == most_tackles_team_id }.teamName
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
    fewest_tackles_team = @teams.find { |team| team.team_id == fewest_tackles_team_id }.teamName
  end
end