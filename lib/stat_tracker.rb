require 'csv'
require_relative 'game'
require_relative 'team'

class StatTracker 
  #include modules

  def self.from_csv(locations)
    new(locations)
  end

  attr_reader :game_data, :team_data, :game_teams_data

  def initialize(locations)
    @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    @team_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def all_games
    @game_data.map do |row|
      Game.new(row)
    end
  end

  def all_teams
    @team_data.map do |row|
      team = Team.new(row)
      team.games = all_games.select { |game| game.home_id == team.team_id || game.away_id == team.team_id }
      team
    end
  end

  def all_game_teams
    @game_teams_data.map do |row|
      GameTeam.new(row)
    end
  end

  def games_by_season
    seasons = Hash.new([])
    all_games.each do |game|
      seasons[game.season] = []
    end
    seasons.each do |season, games_array|
      all_games.each do |game|
        games_array << game if game.season == season
      end
    end
    seasons
  end

  def game_teams_by_season(season)
    games_by_season[season].map do |game|
      all_game_teams.find_all do |game_by_team|
        game.id == game_by_team.game_id
      end
    end.flatten
  end

  def team_name_by_id(team_id)
    all_teams.find { |team| team.team_id == team_id }.team_name
  end

  def avg_score_per_game(total_goals_array)
    total_goals_array.sum.fdiv(total_goals_array.count)
  end
  #=====================================================================================================

  def highest_total_score
    all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end

  def count_of_games_by_season
    # game_count = {}
    games_by_season.transform_values{|value| value.count} 
    # games_by_season.map do |season, games|
    #   game_count[season] = games.count
    # end
    # game_count
  end

  def best_offense
    team_info = all_game_teams.group_by(&:team_id)
    avg_team_goals = Hash.new(0)
    team_info.map do |team, games|
      all_goals = games.map {|game|game.goals}  
      team_avg_goals_per_game = avg_score_per_game(all_goals)
      avg_team_goals[team] = team_avg_goals_per_game
    end
      max_avg_goals = avg_team_goals.max_by do |team, avg_goals|
      avg_goals
    end
    team_name_by_id(max_avg_goals.first)
  end

  def worst_offense
    team_info = all_game_teams.group_by(&:team_id)
    avg_team_goals = Hash.new(0)
    team_info.map do |team, games|
      all_goals = games.map {|game|game.goals}  
      team_avg_goals_per_game = avg_score_per_game(all_goals)
      avg_team_goals[team] = team_avg_goals_per_game
    end
      min_avg_goals = avg_team_goals.min_by do |team, avg_goals|
      avg_goals
    end
    team_name_by_id(min_avg_goals.first)
  end

  def average_goals_by_season
    games_by_season.transform_values do |games_array|
      scores_array = games_array.map(&:total_score)
      (scores_array.sum.to_f / scores_array.length).round(2)
    end
  end

  def count_of_teams
    @team_data.count
  end

  def percentage_home_wins
    team_wins = all_game_teams.select do |team|
      team.result == 'WIN' && team.home_or_away == 'home'
    end
    home_games = all_game_teams.select do |game|
      game.home_or_away == 'home'
    end
    (team_wins.count / home_games.count.to_f).round(2)
  end
  
  def percentage_visitor_wins
    team_wins = all_game_teams.select do |team|
      team.result == 'WIN' && team.home_or_away == 'away'
    end
    away_games = all_game_teams.select do |game|
      game.home_or_away == 'away'
    end
    (team_wins.count / away_games.count.to_f).round(2)
  end

  def percentage_ties
    (1.0 - percentage_home_wins - percentage_visitor_wins).round(2)
  end

  def lowest_scoring_visitor
    team_info = all_games.group_by(&:away_id)
    avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end
    min_avg_score = avg_score.min_by do |_, avg_scores|
      avg_scores
    end
    team_name_by_id(min_avg_score.first)
  end
  
  def highest_scoring_visitor
    team_info = all_games.group_by(&:away_id)
    avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end
    max_avg_score = avg_score.max_by do |_, avg_scores|
      avg_scores
    end
    team_name_by_id(max_avg_score.first)
  end

  def most_tackles(season)
    tackles_by_team = Hash.new(0)
    game_teams_by_season(season).each do |game_team|
      tackles_by_team[game_team.team_id] += game_team.tackles
    end
    max_team_id = tackles_by_team.max_by { |_team_id, tackles| tackles }.first
    team_name_by_id(max_team_id)
  end

  def fewest_tackles(season)
    tackles_by_team = Hash.new(0)
    game_teams_by_season(season).each do |game_team|
      tackles_by_team[game_team.team_id] += game_team.tackles
    end
    min_team_id = tackles_by_team.min_by { |_team_id, tackles| tackles }.first
    team_name_by_id(min_team_id)
  end

  def highest_scoring_home_team
    team_info = all_games.group_by(&:home_id)
    team_avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map do |game|
        game.home_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      team_avg_score[team] = avg_score_per_game
    end
      max_avg_score = team_avg_score.max_by do |team, avg_score|
        avg_score
      end
      team_name_by_id(max_avg_score.first)
  end

  def lowest_scoring_home_team
    team_info = all_games.group_by(&:home_id)
    team_avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map do |game|
        game.home_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      team_avg_score[team] = avg_score_per_game
    end
      min_avg_score = team_avg_score.min_by do |team, avg_score|
        avg_score
      end
      team_name_by_id(min_avg_score.first)
   end

  def most_accurate_team(season)
    most_accurate_id = goals_to_shots_ratio(season).max_by { |_team_id, ratio| ratio }.first
    team_name_by_id(most_accurate_id)
  end

  def least_accurate_team(season)
    least_accurate_id = goals_to_shots_ratio(season).min_by { |_team_id, ratio| ratio }.first
    team_name_by_id(least_accurate_id)
  end

  def goals_to_shots_ratio(season)
    total_goals_by_team = Hash.new(0)
    total_shots_by_team = Hash.new(0)
    game_teams_by_season(season).each do |game_team|
      total_goals_by_team[game_team.team_id] += game_team.goals
      total_shots_by_team[game_team.team_id] += game_team.shots
    end
    total_goals_by_team.merge(total_shots_by_team) { |_team_id, total_goals, total_shots| (total_goals / total_shots.to_f) }
  end
end





