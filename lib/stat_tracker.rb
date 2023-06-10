require "csv"
require_relative "./game"
require_relative "./team"
require_relative "./season"
require_relative "./game_teams"

class StatTracker
  attr_reader :games,
              :teams

  def initialize(locations)
    @games = create_games(locations[:games])
    @teams = create_teams(locations[:teams])
    @game_teams = create_game_teams(locations[:game_teams])
    @season_games = {}
    create_season_games_hash
    @seasons = create_seasons(locations)
    @grouped_game_teams = {}
    group_teams
  end
  
  def create_games(game_path)
    games = []
    game_lines = CSV.open game_path, headers: true, header_converters: :symbol
    game_lines.each do |line|
      games << Game.new(line)
    end
    @games = games
  end
  
  def create_teams(teams_path)
    teams = []
    teams_lines = CSV.open teams_path, headers: true, header_converters: :symbol
    teams_lines.each do |line|
      teams << Team.new(line)
    end
    @teams = teams
  end

  def create_season_games_hash
    @season_games = @games.group_by {|game| game.season}
  end

  def create_game_teams(game_teams_path)
    game_teams = []
    game_teams_lines = CSV.open game_teams_path, headers: true, header_converters: :symbol
    game_teams_lines.each do |line|
      game_teams << GameTeam.new(line)
    end
    @game_teams = game_teams
  end

  def create_seasons(locations)
    seasons = []
    @season_games.keys.each do |season|
      seasons << Season.new(locations[:games], locations[:game_teams], season, locations[:teams])
    end
    @seasons = seasons
  end
  
  def self.from_csv(locations)
    stat_tracker = self.new(locations)
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
    @season_games.each do |season, games|
      game_count[season] = games.count
    end
    game_count
  end

  def average_goals_per_game
    total_goals = @games.sum { |game| game.total_goals }
    total_games = @games.length.to_f
    (total_goals / total_games).round(2)
  end

  def average_goals_by_season
    goal_count = {}
    @season_games.each do |season, games|
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
    team_id_with_most_tackles = season_data.team_tackles.max_by { |team_id, tackles| tackles }[0]
    team_with_most_tackles = @teams.find { |team| team.id == team_id_with_most_tackles }
    team_with_most_tackles.team_name
  end

  def fewest_tackles(season)
    season_data = find_season(season)
    team_id_with_fewest_tackles = season_data.team_tackles.min_by { |team_id, tackles| tackles }[0]
    team_with_fewest_tackles = @teams.find { |team| team.id == team_id_with_fewest_tackles }
    team_with_fewest_tackles.team_name
  end
end