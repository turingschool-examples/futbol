require 'csv'
require_relative 'game_team'
require_relative 'csvloadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams

  def initialize(game_teams_path)
    @game_teams = create_game_teams(game_teams_path)
  end

  def create_game_teams(game_teams_path)
    create_instances(game_teams_path, GameTeam)
  end

  def winningest_team_id
    team_records = all_games_by_team.reduce({}) do |records, games|
      wlt_percent_calculator(games[1], "WIN")
      records[games[0]] = @wlt_percentage
      records
    end
    team_records.max_by { |team_id, percentage| percentage }[0]
  end

  def best_fans_team_id
    home_games_teams = hoa_game_sorter("home")
    away_games_teams = hoa_game_sorter("away")

    home_win_pcts = home_games_teams.reduce({}) do |records, games|
      wlt_percent_calculator(games[1], "WIN")
      records[games[0]] = @wlt_percentage
      records
    end

    away_win_pcts = away_games_teams.reduce({}) do |records, games|
      wlt_percent_calculator(games[1], "WIN")
      records[games[0]] = @wlt_percentage
      records
    end

    home_win_pcts.keys.max_by do |key|
      home_win_pcts[key] - away_win_pcts[key]
    end
  end

  # module candidate?
  def wlt_percent_calculator(games_array, wlt)
    wlt_total = (games_array.find_all { |game| game.result == wlt }).length
    percentage = (wlt_total.to_f / games_array.length.to_f).round(3)
    return @wlt_percentage = 0 if percentage.nan? == true
    @wlt_percentage = percentage
  end

  def all_games_by_team
    @game_teams.group_by { |game| game.team_id }
  end

  def hoa_game_sorter(h_a)
    all_games_by_team.reduce({}) do |records, games|
      records[games[0]] = games[1].find_all {|game| game.hoa == h_a }
      records
    end
  end
end
