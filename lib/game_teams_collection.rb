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

  # module candidate?
  def wlt_percent_calculator(games_array, wlt)
    wlt_total = (games_array.find_all { |game| game.result == wlt }).length
    @wlt_percentage = (wlt_total.to_f / games_array.length.to_f).round(3)
  end

  def all_games_by_team
    @game_teams.group_by { |game| game.team_id }
  end
end
