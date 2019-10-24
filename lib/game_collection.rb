require 'csv'
require './lib/game'
require './lib/stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(game_path)
    @game_path = game_path
    all_games
  end

  def all_games
    @game_instances = []
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      @game_instances <<  Game.new(row)
    end
    @game_instances
  end

  def count_of_games_by_season
    key_maker
    season_count = {}
    @keys.each do |key|
      season_count[key] = value_maker(key)
    end
    season_count
  end

  def key_maker
    @keys = []
    @game_instances.each do |game|
      @keys << game.season
    end
    @keys = @keys.uniq
  end

  def value_maker(season)
    values = []
    @game_instances.each do |game|
      if game.season == season
        values << game
      end
    end
    values
  end
end
