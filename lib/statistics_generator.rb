require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'season'
require 'csv'

class StatisticsGenerator
  
  attr_reader :data, 
              :teams, 
              :games, 
              :game_teams,
              :seasons_by_id
  def initialize(data, teams, games, game_teams)
    @data = data
    @teams = teams
    @games = games
    @game_teams = game_teams
    @seasons_by_id = processed_seasons_data
  end

  def self.from_csv(locations)
    new_locations = {}
    teams = []
    games = []
    game_teams = []

    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end

    new_locations.each do |category, info|
      if category == :teams
        info.each do |row|
          teams << Team.new(row)
        end
      elsif category == :games
        info.each do |row|
          games << Game.new(row)
      end
      else
        info.each do |row|
          game_teams << GameTeam.new(row)
        end
      end
    end

    new(locations, teams, games, game_teams)
  end

  def processed_seasons_data
    all_seasons = Hash.new
    @games.map{|game| game.season}.uniq.each do |season_id|
      new_season = Season.new(season_id, @games, @game_teams)
      all_seasons[season_id] = new_season.season_data
    end
    all_seasons
  end
end