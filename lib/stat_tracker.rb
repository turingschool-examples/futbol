require "csv"
require './lib/game'
require './lib/team'
require './lib/game_teams'

class StatTracker
  attr_reader :games,:teams, :game_teams, :games_array

  def initialize(locations)
    @games = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    @games_array = []
    fill_game_array
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def fill_game_array
    @games.each do |col|
      @game_id = col[:game_id]
      @season = col[:season]
      @type = col[:type]
      @date_time = col[:date_time]
      @away_team_id = col[:away_team_id]
      @home_team_id = col[:home_team_id]
      @away_goals = col[:away_goals]
      @home_goals = col[:home_goals]
      @venue = col[:venue]
      @venue_link = col[:venue_link]
      @games_array << Game.new(@game_id,@season,@type,@date_time,
        @away_team_id,@home_team_id,@away_goals,@home_goals,
        @venue,@venue_link)
      end
  end

  def highest_total_score
    sum = 0
    highest_sum = 0
    @games_array.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      #require 'pry'; binding.pry
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
  end




  end
