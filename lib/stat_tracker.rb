require 'csv'
require_relative './league'

class StatTracker
  attr_reader :league

  def self.from_csv(locations)
    data = {}
    locations.each do |key, csv_file_path|
      data[key] = CSV.open(csv_file_path, headers: true, header_converters: :symbol)
      data[key] = data[key].to_a.map do |row|
        row.to_h
      end
    end
    self.new(:futbol, data)
  end

  def initialize(league_name, data)
    @league = League.new(league_name, data)
  end

  def team_tackles(season_year)
    team_and_tackles = Hash.new(0)
    season = @league.seasons.find{ |season| season.year == season_year }
    season.games.each do |game|
      team_and_tackles[game.team_refs[:home_team].name] += game.team_stats[:home_team][:tackles]
      team_and_tackles[game.team_refs[:away_team].name] += game.team_stats[:away_team][:tackles]
    end

    team_and_tackles
  end

  def team_goals
    team_and_goals = Hash.new(0)
    league.seasons.each do |season|
      season.games.each do |game|
        team_and_goals[game.team_refs[:home_team].name] += game.team_stats[:home_team][:goals]
        team_and_goals[game.team_refs[:away_team].name] += game.team_stats[:away_team][:goals]
      end
    end
    team_and_goals
  end
  
  def team_games
    team_and_games = Hash.new(0)
    league.seasons.each do |season|
      season.games.each do |game|
        home_team_name = game.team_refs[:home_team].name
        away_team_name = game.team_refs[:away_team].name
        team_and_games[home_team_name] += 1
        team_and_games[away_team_name] += 1
      end
    end
    team_and_games
  end

  def avg_goals
    team_and_goals_per_game = {}
    team_and_goals = team_goals
    team_and_games = team_games
    team_and_goals.each do |team, goals|
      games = team_and_games[team]
      goals_per_game = games > 0 ? goals.to_f / games : 0
      team_and_goals_per_game[team] = goals_per_game
    end
    avg_goals_per_game = team_and_goals_per_game.values.sum / team_and_goals_per_game.size.to_f
    { "average" => avg_goals_per_game }.merge(team_and_goals_per_game)
  end

  def total_goals_per_game
    @league.games.map do |game|
      game.info[:home_goals] + game.info[:away_goals]
    end
  end

  def highest_total_score
    total_goals_per_game.max
  end

  def lowest_total_score
    total_goals_per_game.min
  end

  def percentage_game_result(team, result)
    count = @league.games.count do |game|
      game.team_stats[team][:result] == result
    end
    count.fdiv(@league.games.length)
  end

  def percentage_home_wins
    percentage_game_result(:home_team, "WIN").round(4)
  end

  def percentage_visitor_wins
    percentage_game_result(:home_team, "LOSS").round(4)
  end

  def percentage_ties
    percentage_game_result(:home_team, "TIE").round(4)
  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end

  def count_of_teams
    @league.teams.count
  end

  def best_offense
    team_and_goals_per_game = avg_goals
    team_and_goals_per_game.max_by { |team, goals_per_game| goals_per_game }.first
  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end

  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def most_tackles(season_year)
    team_tackles(season_year).max_by { |team, tackles| tackles }.first
  end

  def fewest_tackles(season_year)
    team_tackles(season_year).min_by { |team, tackles| tackles }.first
  end
end