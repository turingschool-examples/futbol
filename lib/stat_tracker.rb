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
    percentage_game_result(:home_team, "WIN").round(2)
  end

  def percentage_visitor_wins
    percentage_game_result(:home_team, "LOSS").round(2)
  end

  def percentage_ties
    percentage_game_result(:home_team, "TIE").round(2)
  end

  # def count_of_games_by_season

  # end

  # def average_goals_per_game

  # end

  # def average_goals_by_season

  # end

  # def count_of_teams

  # end

  # def best_offense

  # end

  # def worst_offense

  # end

  # def highest_scoring_visitor

  # end

  # def lowest_scoring_visitor

  # end

  # def lowest_scoring_home_team

  # end

  def wins_losses_by_coach(season_year)
    season = @league.seasons.find do |season|
      season.year == season_year
    end
    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)
    season.games.each do |game|
      if game.team_stats[:home_team][:result] == 'WIN'
        coach_wins[game.team_stats[:home_team][:head_coach]] += 1
      elsif game.team_stats[:away_team][:result] == 'WIN'
        coach_wins[game.team_stats[:away_team][:head_coach]] += 1
      elsif game.team_stats[:home_team][:result] == 'LOSS'
        coach_losses[game.team_stats[:home_team][:head_coach]] += 1
      elsif game.team_stats[:away_team][:result] == 'LOSS'
        coach_losses[game.team_stats[:away_team][:head_coach]] += 1
      end
    end
    [coach_wins, coach_losses]
  end

  def games_coached(season_year)
    season = @league.seasons.find do |season|
      season.year == season_year
    end
    coach_games = Hash.new(0)
    season.games.each do |game|
      coach_games[game.team_stats[:home_team][:head_coach]] += 1
      coach_games[game.team_stats[:away_team][:head_coach]] += 1
    end
    coach_games
  end

  def count_of_teams
    @league.teams.count
  end

  def best_offense
    team_and_goals_per_game = avg_goals
    team_and_goals_per_game.max_by { |team, goals_per_game| goals_per_game }.first
  end

  def worst_offense
    team_and_goals_per_game = avg_goals
    team_and_goals_per_game.min_by { |team, goals_per_game| goals_per_game }.first
  end

  def highest_scoring_visitor

  
  def winningest_coach(season_year)
    coach_game_count = games_coached(season_year)
    coach_win_count = wins_losses_by_coach(season_year).first
    coach_win_rate = {}
    coach_game_count.each do |coach, game_count|
      coach_win_rate[coach] = coach_win_count[coach].fdiv(coach_game_count[coach])
    end
    max_win_rate = 0
    winningest_coach = nil
    coach_win_rate.each do |coach, win_rate|
      if win_rate > max_win_rate
        max_win_rate = win_rate
        winningest_coach = coach
      end
    end
    winningest_coach
  end

  def worst_coach(season_year)
    coach_game_count = games_coached(season_year)
    coach_loss_count = wins_losses_by_coach(season_year).last
    coach_loss_rate = {}
    coach_game_count.each do |coach, game_count|
      coach_loss_rate[coach] = coach_loss_count[coach].fdiv(coach_game_count[coach])
    end
    max_loss_rate = 0
    worst_coach = nil
    coach_loss_rate.each do |coach, loss_rate|
      if loss_rate > max_loss_rate
        max_loss_rate = loss_rate
        worst_coach = coach
      end
    end
    worst_coach
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