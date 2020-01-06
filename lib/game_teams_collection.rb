require 'csv'
require_relative 'game_team'
require_relative 'csvloadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams

  def initialize(game_teams_path)
    @game_teams = create_game_teams(game_teams_path)
    all_games_by_team_id
  end

  def create_game_teams(game_teams_path)
    create_instances(game_teams_path, GameTeam)
  end

  def winningest_team_id
    team_records = percent_sort_by_id(@all_games_by_team, "WIN")
    team_records.max_by { |team_id, percentage| percentage }[0]
  end

  def best_fans_team_id
    home_win_percents.keys.max_by do |key|
      (home_win_percents[key] - away_win_percents[key])
    end
  end

  def worst_fans_team_id
    home_win_percents.keys.find_all do |key|
      (home_win_percents[key] < away_win_percents[key])
    end
  end

  def all_games_by_team_id
    @all_games_by_team = @game_teams.group_by { |game| game.team_id }
  end

  def home_win_percents
    home_games_teams = hoa_game_sorter("home")
    percent_sort_by_id(home_games_teams, "WIN")
  end

  def away_win_percents
    away_games_teams = hoa_game_sorter("away")
    percent_sort_by_id(away_games_teams, "WIN")
  end

  def percent_sort_by_id(to_sort, stat)
    to_sort.reduce({}) do |records, games|
      wlt_percent_calculator(games[1], stat)
      records[games[0]] = @wlt_percentage
      records
    end
  end

  def wlt_percent_calculator(games_array, stat)
    wlt_total = (games_array.find_all { |game| game.result == stat }).length
    percentage = (wlt_total.to_f / games_array.length.to_f).round(3)
    return @wlt_percentage = 0 if percentage.nan? == true
    @wlt_percentage = percentage
  end

  def hoa_game_sorter(h_a)
    @all_games_by_team.reduce({}) do |records, games|
      records[games[0]] = games[1].find_all {|game| game.hoa == h_a }
      records
    end
  end

  def all_games_by_season(season_id)
   @game_teams.find_all do |game|
     game if game.game_id.to_s[0..3] == season_id[0..3]
   end
  end

  def season_by_team(season)
    games_by_season = all_games_by_season(season)
    games_by_season.group_by do |game|
      game.team_id
    end
  end

  def team_total_tackles(season)
    team_total_tackles =  {}
    season_by_team(season).map do |id, games|
      team_total_tackles[id] = games.sum do |game|
        game.tackles
      end
    end
    team_total_tackles
  end

  def most_tackles_team_id(season)
    most_tackles = team_total_tackles(season).max_by do |team_id, totaltackles|
      totaltackles
    end.first
  end

  def fewest_tackles_team_id(season)
    fewest_tackles_team_id_tackles = team_total_tackles(season).min_by do |team_id, totaltackles|
      totaltackles
    end.first
  end
end
