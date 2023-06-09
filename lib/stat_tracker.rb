require "csv"
require "./lib/game"
require "./lib/team"
require "./lib/season"

class StatTracker
  attr_reader :games,
              :teams

  def initialize
    @games = []
    @teams = []
    @season_teams = {}
    @game_teams = []
    @grouped_game_teams = {}
    @seasons = []
  end
  
  def create_games(game_path)
    game_lines = CSV.open game_path, headers: true, header_converters: :symbol
    game_lines.each do |line|
      @games << Game.new(line)
    end
  end
  
  def create_teams(teams_path)
    teams_lines = CSV.open teams_path, headers: true, header_converters: :symbol
    teams_lines.each do |line|
      @teams << Team.new(line)
    end
  end

  def create_season_hash
    @season_teams = @games.group_by {|game| game.season}
  end

  def create_game_teams(game_teams_path)
    game_teams_lines = CSV.open game_teams_path, headers: true, header_converters: :symbol
    game_teams_lines.each do |line|
      @game_teams << GameTeam.new(line)
    end
  end

  def create_seasons(game_path, game_teams_path, teams_path)
    @season_teams.keys.each do |season|
      @seasons << Season.new(game_path, game_teams_path, season, teams_path)
    end
  end
  
  def self.from_csv(game_path, teams_path, game_teams_path)
    stat_tracker = self.new
    stat_tracker.create_games(game_path)
    stat_tracker.create_teams(teams_path)
    stat_tracker.create_season_hash
    stat_tracker.create_game_teams(game_teams_path)
    stat_tracker.create_seasons(game_path, game_teams_path, teams_path)
    stat_tracker.group_teams
    stat_tracker
  end

  def highest_total_score
    @games.max_by{|game| game.total_goals}.total_goals
  end

  def lowest_total_score
    @games.min_by{|game| game.total_goals}.total_goals
  end

  def percentage_home_wins
    home_wins = @games.count{|game| game.home_win?}
    total_games = @games.length
    (home_wins/total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count{|game| game.visitor_win?}
    total_games = @games.length
    (visitor_wins/total_games.to_f).round(2)
  end

  def percentage_ties
    ties = @games.count{|game| game.home_goals == game.away_goals}
    total_games = @games.length
    (ties/total_games.to_f).round(2)
  end 

  def count_of_games_by_season
    game_count = {}
    @season_teams.each do |season, games|
      game_count[season] = games.count
    end
    game_count
  end

  def average_goals_per_game
    average_goals = @games.map {|game| game.goals_averaged}
    (average_goals.sum.to_f/average_goals.count).round(2)
  end

  def average_goals_by_season
    goal_count = {}
    @season_teams.each do |season, games|
      averaged_goals = games.map {|game| game.goals_averaged}
      combined_average = (averaged_goals.sum.to_f/averaged_goals.count).round(2)
      goal_count[season] = combined_average
    end
    goal_count
  end

  def count_of_teams
    @teams.count
  end

  def group_teams
    @grouped_game_teams = @game_teams.group_by do |team|
      team.team_id
    end
  end
  #move into helper class?
  def offense_helper
    team_average_scores = {}
    @grouped_game_teams.each do |team, games|
      game_scores = games.map { |game| game.goals }
      average_goals = game_scores.sum.to_f/game_scores.length
      team_average_scores[team] = average_goals
    end
    team_average_scores
  end

  def best_offense
    top_team_array = offense_helper.max_by {|team, score| score}
    top_team_id = top_team_array[0].to_s
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end

  def worst_offense
    worst_team_array = offense_helper.min_by {|team, score| score}
    worst_team_id = worst_team_array[0].to_s
    worst_team = @teams.find {|team| team.id == worst_team_id }
    worst_team.team_name
  end

  def scoring_helper_method(home_or_away_status)
    sorted_scores = {}
    @grouped_game_teams.each do |team, games|
      selected_games = games.select {|game| game.home_or_away == home_or_away_status}
      scores = selected_games.map { |game| game.goals }
      average_score = scores.sum.to_f/scores.length
      sorted_scores[team] = average_score
    end
    sorted_scores
  end

  def highest_scoring_visitor
    top_team_array = scoring_helper_method("away").max_by {|team, score| score}
    top_team_id = top_team_array[0]
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end

  def lowest_scoring_visitor
    worst_team_array = scoring_helper_method("away").min_by {|team, score| score}
    worst_team_id = worst_team_array[0]
    worst_team = @teams.find {|team| team.id == worst_team_id }
    worst_team.team_name
  end

  def highest_scoring_home_team
    top_team_array = scoring_helper_method("home").max_by {|team, score| score}
    top_team_id = top_team_array[0]
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end

  def lowest_scoring_home_team
    worst_team_array = scoring_helper_method("home").min_by {|team, score| score}
    worst_team_id = worst_team_array[0]
    worst_team = @teams.find {|team| team.id == worst_team_id }
    worst_team.team_name
  end

  def coach_stats(season)
    coach_data = find_season(season).game_teams.group_by {|game| game.head_coach}
    # require 'pry'; binding.pry
    coach_percentages = {}
    coach_data.each do |coach, games|
      wins = games.count { |game| game.result == "WIN" }
      win_percentage = wins.to_f/games.length
      coach_percentages[coach] = win_percentage
    end
    coach_percentages
  end
  
  def find_season(season_id)
    @seasons.find do |season|
      season.season == season_id
    end
  end

  def winningest_coach(season)
    best_coach_stats = coach_stats(season).max_by {|coach, percentage| percentage}
    best_coach_stats[0]
  end

  def worst_coach(season)
    worst_coach_stats = coach_stats(season).min_by {|coach, percentage| percentage}
    worst_coach_stats[0]
  end

  def most_accurate_team(season)
    id_hash = find_season(season).game_teams.group_by { |game_team_object| game_team_object.team_id }
    team_percentages = {}
    id_hash.each do |team_id, games_array|
      team_accuracy = games_array.map { |game_team_object| game_team_object.accuracy }
      accurate_percentage = team_accuracy.sum.to_f / team_accuracy.length
      team_percentages[team_id] = accurate_percentage
    end
    top_team_array = team_percentages.max_by {|team_id, percentage| percentage }
    top_team_id = top_team_array[0]
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end

  def least_accurate_team(season)
    id_hash = find_season(season).game_teams.group_by { |game_team_object| game_team_object.team_id }
    team_percentages = {}
    id_hash.each do |team_id, games_array|
      team_accuracy = games_array.map { |game_team_object| game_team_object.accuracy }
      accurate_percentage = team_accuracy.sum.to_f / team_accuracy.length
      team_percentages[team_id] = accurate_percentage
    end
    top_team_array = team_percentages.min_by {|team_id, percentage| percentage }
    top_team_id = top_team_array[0]
    top_team = @teams.find {|team| team.id == top_team_id }
    top_team.team_name
  end

  def most_tackles(season)
    season_data = find_season(season)
    team_tackles = Hash.new(0)

    season_data.game_teams.each do |game_team|
      team_id = game_team.team_id
      tackles = game_team.tackles

      team_tackles[team_id] += tackles
    end

    team_id_with_most_tackles = team_tackles.max_by { |_, tackles| tackles }[0]
    team_with_most_tackles = @teams.find { |team| team.id == team_id_with_most_tackles }

    return team_with_most_tackles.team_name
  end
end