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
          one_game = Game.new(
            row[:game_id],
            row[:season],
            row[:type],
            row[:away_team_id],
            row[:home_team_id],
            row[:away_goals,],
            row[:home_goals],
            row[:venue]
            )
          end
          game_array << games
        elsif key == :teams
          teams = CSV.read(database_hash[:teams], headers: true, header_converters: :symbol).map do |row|
            one_team = Team.new(
              row[:team_id],
              row[:franchiseid],
              row[:teamname],
              row[:stadium]
              )
            end
            team_array << teams
        else
          game_teams = CSV.read(database_hash[:game_teams], headers: true, header_converters: :symbol).map do |row|
            one_game_team = GameTeams.new(
              row[:game_id],
              row[:team_id],
              row[:hoa],
              row[:result],
              row[:head_coach],
              row[:goals],
              row[:tackles]
              )
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
      require 'pry'; binding.pry
    end



end