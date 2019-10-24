require 'csv'
require_relative 'game'
require_relative 'stat_tracker'

class GameCollection
  attr_reader :game_instances

  def initialize(game_path)
    @game_path = game_path
    @game_instances = all_games
  end

  def all_games
    csv = CSV.read("#{@game_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       Game.new(row)
    end
  end

  def count_of_games_by_season
    season_key_maker
    season_count = {}
    @keys.each do |key|
      season_count[key] = value_maker(key)
    end
    season_count
  end

  def season_key_maker
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
