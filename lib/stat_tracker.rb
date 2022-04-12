require 'csv'
class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = create_games(games)
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
    stat_tracker1 = self.new(games, teams, game_teams)
    # require "pry";binding.pry
  end

  def create_games(games)
    game_arr = []
    games.each do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      game_arr << Game.new(game_id, season, type, date_time, away_team_id, home_team_id,
        away_goals, home_goals, venue, venue_link)
    end
  return game_arr
  end
end
