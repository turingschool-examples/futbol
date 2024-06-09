require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
    attr_reader :games, :teams, :game_teams

    def self.from_csv(locations)
      games = parse_csv(locations[:games], Game)
      teams = parse_csv(locations[:teams], Team)
      game_teams = parse_csv(locations[:game_teams], GameTeam)
  
      new(games, teams, game_teams)
    end

    def self.parse_csv(filepath, class_object)
      CSV.read(filepath, headers: true, header_converters: :symbol).map do |data|
        
        class_object.new(data)
      end
    end

    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end

    # Game Statistics
  def highest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.max
  end

  def lowest_total_score
    @games.map { |game| game.away_goals + game.home_goals }.min
  end

  def percentage_home_wins
    total_games = @games.size
    home_wins = @games.count { |game| game.home_goals > game.away_goals }
    (home_wins.to_f / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = @games.size
    visitor_wins = @games.count { |game| game.away_goals > game.home_goals }
    (visitor_wins.to_f / total_games).round(2)
  end

  def percentage_ties
    total_games = @games.size
    ties = @games.count { |game| game.away_goals == game.home_goals }
    (ties.to_f / total_games).round(2)
  end

  def count_of_games_by_season
    @games.group_by { |game| game.season }.transform_values(&:count)
  end

  def average_goals_per_game
    total_goals = @games.sum { |game| game.away_goals + game.home_goals }
    (total_goals.to_f / @games.size).round(2)
  end

  def average_goals_by_season
    season_goals = @games.group_by { |game| game.season }
    season_goals.transform_values do |games|
      total_goals = games.sum { |game| game.away_goals + game.home_goals }
      (total_goals.to_f / games.size).round(2)
    end
  end

  # League Statistics
  def count_of_teams
    @teams.size
  end

  def best_offense
    team_avg_goals = @game_teams.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      (total_goals.to_f / games.size).round(2)
    end 
    
    best_team_id = team_avg_goals.max_by { |_, avg_goals| avg_goals }&.first
    @teams.find { |team| team.team_id == best_team_id }&.teamName
  end

  def worst_offense
    team_avg_goals = @game_teams.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      (total_goals.to_f / games.size).round(2)
    end
    worst_team_id = team_avg_goals.min_by { |_, avg_goals| avg_goals }&.first
    @teams.find { |team| team.team_id == worst_team_id }&.teamName
  end

  def highest_scoring_visitor
    team_avg_away_goals = @game_teams.select { |gt| gt.HoA == "away" }.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      avg_goals = (total_goals.to_f / games.size).round(2)
    end
    best_team_id = team_avg_away_goals.max_by { |_, avg_goals| avg_goals }&.first
    team_name = @teams.find { |team| team.team_id == best_team_id }&.teamName
    puts "Highest Scoring Visitor Team ID: #{best_team_id}, Name: #{team_name}"
    team_name
  end
  
  def highest_scoring_home_team
    team_avg_home_goals = @game_teams.select { |gt| gt.HoA == "home" }.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      (total_goals.to_f / games.size).round(2)
    end
    best_team_id = team_avg_home_goals.max_by { |_, avg_goals| avg_goals }&.first
    @teams.find { |team| team.team_id == best_team_id }&.teamName
  end

  def lowest_scoring_visitor
    team_avg_away_goals = @game_teams.select { |gt| gt.HoA == "away" }.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      (total_goals.to_f / games.size).round(2)
    end
    worst_team_id = team_avg_away_goals.min_by { |_, avg_goals| avg_goals }&.first
    @teams.find { |team| team.team_id == worst_team_id }&.teamName
  end

  def lowest_scoring_home_team
    team_avg_home_goals = @game_teams.select { |gt| gt.HoA == "home" }.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      avg_goals = (total_goals.to_f / games.size).round(2)
    end
    worst_team_id = team_avg_home_goals.min_by { |_, avg_goals| avg_goals }&.first
    team_name = @teams.find { |team| team.team_id == worst_team_id }&.teamName
    puts "Lowest Scoring Home Team ID: #{worst_team_id}, Name: #{team_name}"
    team_name
  end

  # Season Statistics
  def winningest_coach(season)
    season_games = @game_teams.select { |gt| @games.any? { |game| game.game_id == gt.game_id && game.season == season } }
    coach_wins = season_games.group_by(&:head_coach).transform_values do |games|
      total_games = games.size
      wins = games.count { |game| game.result == "WIN" }
      (wins.to_f / total_games).round(2)
    end
    coach_wins.max_by { |_, win_percentage| win_percentage }&.first
  end

  def worst_coach(season)
    season_games = @game_teams.select { |gt| @games.any? { |game| game.game_id == gt.game_id && game.season == season } }
    coach_wins = season_games.group_by(&:head_coach).transform_values do |games|
      total_games = games.size
      wins = games.count { |game| game.result == "WIN" }
      (wins.to_f / total_games).round(2)
    end
    coach_wins.min_by { |_, win_percentage| win_percentage }&.first
  end

  def most_accurate_team(season)
    season_games = @game_teams.select { |gt| @games.any? { |game| game.game_id == gt.game_id && game.season == season } }
    team_accuracy = season_games.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      total_shots = games.sum(&:shots)
      (total_goals.to_f / total_shots).round(2)
    end
    best_team_id = team_accuracy.max_by { |_, accuracy| accuracy }&.first
    @teams.find { |team| team.team_id == best_team_id }&.teamName
  end

  def least_accurate_team(season)
    season_games = @game_teams.select { |gt| @games.any? { |game| game.game_id == gt.game_id && game.season == season } }
    team_accuracy = season_games.group_by(&:team_id).transform_values do |games|
      total_goals = games.sum(&:goals)
      total_shots = games.sum(&:shots)
      (total_goals.to_f / total_shots).round(2)
    end
    worst_team_id = team_accuracy.min_by { |_, accuracy| accuracy }&.first
    @teams.find { |team| team.team_id == worst_team_id }&.teamName
  end

  def most_tackles(season)
  season_games = @game_teams.select { |gt| @games.any? { |game| game.game_id == gt.game_id && game.season == season } }
  team_tackles = season_games.group_by(&:team_id).transform_values do |games|
    total_tackles = games.sum(&:tackles)
  end
  best_team_id = team_tackles.max_by { |_, tackles| tackles }&.first
  team_name = @teams.find { |team| team.team_id == best_team_id }&.teamName
  puts "Most Tackles Team ID: #{best_team_id}, Name: #{team_name}"
  team_name
  end

  def fewest_tackles(season)
    season_games = @game_teams.select { |gt| @games.any? { |game| game.game_id == gt.game_id && game.season == season } }
    team_tackles = season_games.group_by(&:team_id).transform_values do |games|
      total_tackles = games.sum(&:tackles)
    end
    worst_team_id = team_tackles.min_by { |_, tackles| tackles }&.first
    team_name = @teams.find { |team| team.team_id == worst_team_id }&.teamName
    puts "Fewest Tackles Team ID: #{worst_team_id}, Name: #{team_name}"
    team_name
  end
  
end 
