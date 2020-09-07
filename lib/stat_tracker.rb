require "csv"
require "./lib/team"
require "./lib/game"
require "./lib/game_team"

class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations = {games: './data/games_sample.csv', teams: './data/teams_sample.csv', game_teams: './data/game_teams_sample.csv'})
    Game.from_csv(locations[:games])
    Team.from_csv(locations[:teams])
    GameTeam.from_csv(locations[:game_teams])
    self.new(Team.all_teams, Game.all_games, GameTeam.all_game_teams)
  end

  def seasonal_game_data
    seasonal_game_data = @games.group_by do |row|
      row.season
    end
    seasonal_game_data
  end

  def avg_score_by_season
    avg_score_by_season = {}
    seasonal_game_data.each do |season, details|
      game_count = 0
      season_goals = 0
      details.each do |row|
        game_count += 1
        season_goals += row.home_goals + row.away_goals
      end
      avg_score_by_season[season] = (season_goals / game_count.to_f).round(2)
    end
    avg_score_by_season
  end

end
