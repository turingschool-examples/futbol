require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'


class StatTracker

  def initialize(data_hash)
    @games = data_hash[:games]
    @teams = data_hash[:teams]
    @game_teams = data_hash[:game_teams]
  end

  def self.from_csv(database_hash)
    # first iterate through database and access whichever one you want
    data_hash = {}
    game_array = []
    team_array = []
    game_teams_array = []
    database_hash.map do |key, value|
      if key == :games
        games = CSV.read(database_hash[:games], headers: true, header_converters: :symbol).map do |row|
          one_game = Game.new(row)
          end
          game_array << games
        elsif key == :teams
          teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
            one_team = Team.new(row)
            end
            team_array << teams
        else
          game_teams = CSV.read(database_hash[:game_teams], headers: true, header_converters: :symbol).map do |row|
            one_game_team = GameTeams.new(row)
            end
            game_teams_array << game_teams
        end
      end
      data_hash[:games] = game_array.flatten
      data_hash[:teams] = team_array.flatten
      data_hash[:game_teams] = game_teams_array.flatten
      new(data_hash)
    end

  def highest_total_score
      max_game = @games.max_by do |game|
        game.home_goals + game.away_goals
      end
      max_game.home_goals + max_game.away_goals
  end

  def average_goals_per_game
    goals = 0
    total_games = @games.count
    avg_goals = @games.each { |game| goals += game.away_goals + game.home_goals }
    (goals.to_f / total_games).round(2)
  end


end