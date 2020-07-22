require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'

class StatTracker

  game_path = './data/games.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
  attr_reader :game_teams, :games, :teams, :seasons
  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    @game_teams = []
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      @game_teams << GameTeam.new(row)
    end
    @games = []
    CSV.foreach(locations[:games], headers: true) do |row|
      @games << Game.new(row)
    end
    @teams = []
    CSV.foreach(locations[:teams], headers: true) do |row|
      @teams << Team.new(row)
    end
    @seasons = {}
    generate_seasons
  end

  def generate_seasons
    seasons_list = @games.map {|game| game.season}.uniq.sort
    seasons_list.each {|season| @seasons[season] = []}
    @games.each {|game| @seasons[game.season] << game}
  end

  # def games_coached(season)
  #   coaches = []
  #   @seasons[season].each do |season_game|
  #     @game_teams.each do |game|
  #       if season_game.game_id == game.game_id
  #         coaches << game.head_coach
  #       end
  #     end
  #   end
  #   games_coached = Hash.new(0)
  #   coaches.each {|coach| games_coached[coach] += 1}
  #   games_coached
  # end

end
