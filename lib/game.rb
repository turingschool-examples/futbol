require './lib/stat_tracker.rb'
require 'csv'

class Game
  attr_reader :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(game_info)
    @season = game_info[:season]
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals]
    @home_goals = game_info[:home_goals]
    @venue = game_info[:venue]
    @venue_link = game_info[:venue_link]
  end

  def self.create_multiple_games(locations)
    games = CSV.parse(File.read(locations), headers: true, header_converters: :symbol).map(&:to_h)
    games_as_objects = games.map { |row| Game.new(row) }
    
  end

  




end

