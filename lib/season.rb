require "CSV"
require_relative './game'

class Season

  @@all = []

  def self.all
    @@all
  end

  def self.reset_all
    @@all = []
  end

  attr_reader :id, :games_by_type, :games_unsorted

  def initialize(season_hash, gt_path)
    @id = season_hash[:id].to_i
    @games_by_type = games_gather(season_hash[:path], gt_path)
    @games_unsorted = @games_by_type.values.flatten
    @@all << self
  end

  def games_gather(games_path, gt_path)
    stats_hash = Hash.new {|hash, key| hash[key] = []}
    CSV.foreach(gt_path, :headers => true, header_converters: :symbol) do |row|
      stats_hash[row[0]] << {team_id: row[1], HOA: row[2], Coach: row[5], Shots: row[7], Tackles: row[8]}
    end
    game_sort_hash = Hash.new { |hash, key| hash[key] = [] }
    CSV.foreach(games_path, :headers => true, header_converters: :symbol) do |row|
      if row[1].to_i == @id
        game_sort_hash[(row[2])].push((Game.new(row, stats_hash.shift)))
      end
    end
    game_sort_hash
  end

  def number_of_games_by_type(type)
    games_by_type[type].length
  end

  def total_games
    @games_unsorted.length
  end

  # def average_score(season)
  #
  # end
end
