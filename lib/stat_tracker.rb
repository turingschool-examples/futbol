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
      team_and_tackles[game.team_refs[:home_team].name] += game.team_stats[:home_team][:tackles].to_i
      team_and_tackles[game.team_refs[:away_team].name] += game.team_stats[:away_team][:tackles].to_i
    end
    team_and_tackles
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
    percentage_game_result(:home_team, "WIN").round(2)
  end

  def percentage_visitor_wins
    percentage_game_result(:home_team, "LOSS").round(2)
  end

  def percentage_ties
    percentage_game_result(:home_team, "TIE").round(2)
  end

  def count_of_games_by_season

  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def highest_scoring_visitor

  end

  def lowest_scoring_visitor

  end

  def lowest_scoring_home_team

  end
  
  def winningest_coach(season_year)
    games_season = @league.seasons.find{ |season| season.year == season_year }
    wins_coached = Hash.new(0)
    games_coached = Hash.new(0)
    coach_win_percentage = Hash.new
    games_season.each do |game|
      games_coached[game.team_stats[:head_coach]] += 1
      if game.team_stats[:result] == "WIN"
        wins_coached[game.team_stats[:head_coach]] += 1
      end
    end
    games_coached.each do |coach, games|
      wins_coached.each do |coach_win, games_win|
        if coach == coach_win
          coach_win_percentage[coach] = coach_win.fdiv(games)
        end
      end
    end
    coach_win_percentage.max_by {|coach, percentage| percentage}[0]
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

game_path = './spec/fixtures/games_sample.csv'
team_path = './data/teams.csv'
game_teams_path = './spec/fixtures/game_teams_sample.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
