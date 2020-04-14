require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class Stats

  attr_reader :games, :teams, :game_teams

  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    Stats.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    Game.from_csv(games_path)
    GameTeam.from_csv(game_teams_path)
    Team.from_csv(teams_path)

    @@games = Game.all
    @@teams = Team.all
    @@game_teams = GameTeam.all
  end

  def self.games
    @@games
  end

  def self.teams
    @@teams
  end

  def self.game_teams
    @@game_teams
  end

  def team_games_by_season(season) # test
    season_games = @@games.find_all{|game| game.season == season}
    season_game_ids = season_games.map{|game| game.game_id}
    @@game_teams.find_all{|team| season_game_ids.include?(team.game_id)}
  end

end
