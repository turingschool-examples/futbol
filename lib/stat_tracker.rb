require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './raw_stats'

class StatTracker
  attr_reader :stats

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
  # Variable names for methods to be implimented
    @stats = RawStats.new(data)
    @games = stats.games
    @teams = stats.teams
    @game_teams = stats.game_teams
    #require 'pry'; binding.pry
  # How do we want to get these objects to have statistics characteristics (for connecting raw stats)?
  # class GameStats < RawStats
  end

  
  # Game Statistics
  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    total_games = @games.length
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
    (home_wins.to_f / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.length
    visitor_wins = @games.count { |game| game.away_goals > game.home_goals }
    (visitor_wins.to_f / total_games).round(2)
  end

  def percentage_ties
    total_games = @games.length
    ties = @games.count { |game| game.home_goals == game.away_goals }
    (ties.to_f / total_games).round(2)
  end

  def count_of_games_by_season
    result = {}
    @games.each do |game|
      if result[game.season].nil?
        result[game.season] = 1
      else
        result[game.season] += 1
      end
    end
    result
  end

  def average_goals_per_game
    game_totals = @games.map do |game|
      game.away_goals + game.home_goals
    end
    number_of_games = game_totals.length
    game_totals.sum.fdiv(number_of_games).round(2)
  end

  def average_goals_by_season
    result = {}
    season_groups = @games.group_by { |game| game.season }
    season_groups.each do |season, games|
      season_totals = games.map { |game| game.away_goals + game.home_goals}
      number_of_games = season_totals.length
      season_average = season_totals.sum.fdiv(number_of_games).round(2)
      result[season] = season_average
    end
    result
  end

  # League Statistics

  def count_of_teams
    @teams.uniq.count
  end

  #This is a helper method for .best_offense and .worst_offense
  def avg_goals_by_team
    teams_data = @game_teams.group_by { |team| team.team_id} # group data by team
    teams_data.each do |team_id, game_info|
      sum = game_info.sum { |game| game.goals}
      num_games = game_info.count
      teams_data[team_id] = (sum / num_games.to_f).round(2)
    end
  end

  def best_offense
    highest = avg_goals_by_team.max_by { |team_id, avg_goals|  avg_goals }
    best = @teams.find { |team| team.team_id == highest[0]}
    best.team_name
  end

  def worst_offense
    lowest = avg_goals_by_team.min_by { |team_id, avg_goals|avg_goals }
    worst = @teams.find { |team| team.team_id == lowest[0]}
    worst.team_name
  end

  def highest_scoring_visitor
    team_scores = calculate_team_scores(:away_team_id)
    team_id_with_highest_score = team_scores.max_by { |_team_id, score| score }&.first
    team_with_highest_score = @teams.find { |team| team.team_id == team_id_with_highest_score }
    team_with_highest_score&.team_name
  end

  def highest_scoring_home_team
    team_scores = calculate_team_scores(:home_team_id)
    team_id_with_highest_score = team_scores.max_by { |_team_id, score| score }&.first
    team_with_highest_score = @teams.find { |team| team.team_id == team_id_with_highest_score }
    team_with_highest_score&.team_name
  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

  # Season Statistics

  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team
    team_accuracies = calculate_team_accuracies
    team_accuracies.max_by { |team, _| team_accuracies[team] }[0]
  end

  def least_accurate_team
    team_accuracies = calculate_team_accuracies
    team_accuracies.min_by { |team, _| team_accuracies[team] }[0]
  end

  def calculate_team_accuracies
    team_goals = Hash.new { |hash, key| hash[key] = [0, 0] }
    @game_teams.each do |game|
      team_goals[game.team_id][0] += game.goals
      team_goals[game.team_id][1] += game.shots
    end
  
    team_accuracies = {}
    team_goals.each do |team_id, (goals, shots)|
      accuracy = (goals.to_f / shots.to_f) * 100
      team_name = team_name_by_id(team_id)
      team_accuracies[team_name] = accuracy.round(2)
    end
  
    team_accuracies
  end

  def team_name_by_id(team_id)
    team = @teams.find { |team| team.team_id == team_id }
    team.team_name if team
  end

  def most_tackles(season_id)
    games_in_season = @game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end
    games_group_by_team = games_in_season.group_by { |team| team.team_id }
    team_tackles = games_group_by_team.map do |team, tackles|
    [team, tackles.map { |game| game.tackles}]
    end
    tackle_totals = team_tackles.map {|team, tackles| [team, tackles.sum]}.to_h
    highest_total = tackle_totals.max_by { |team, tackles| tackles}
    @teams.find { |team| team.team_id == highest_total.first}.team_name
  end

  def fewest_tackles(season_id)
    games_in_season = @game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end
    games_group_by_team = games_in_season.group_by { |team| team.team_id }
    team_tackles = games_group_by_team.map do |team, tackles|
    [team, tackles.map { |game| game.tackles}]
    end
    tackle_totals = team_tackles.map {|team, tackles| [team, tackles.sum]}.to_h
    highest_total = tackle_totals.min_by { |team, tackles| tackles}
    @teams.find { |team| team.team_id == highest_total.first}.team_name
  end

  def calculate_team_scores(team_id_key)
    team_scores = Hash.new(0)
    @games.each do |game|
      team_id = game.send(team_id_key)
      team_scores[team_id] += game.home_goals + game.away_goals
    end
    team_scores
  end
  # Implement the remaining methods for statistics calculations
  # ...
end
