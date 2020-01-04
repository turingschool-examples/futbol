require "CSV"
require_relative './game'

class Season

  @@all = []

  def self.all
    @@all
  end

  def self.from_csv(season_path, gt_path)
    season_ids = []
		season_storage = []
		CSV.foreach(season_path, :headers => true, header_converters: :symbol) do |row|
			season_ids.push(row[1])
		end
		season_ids.uniq.each {|id| season_storage.push(Season.new({id: id, path: season_path}, gt_path))}
		season_storage
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
        game_sort_hash[(row[2])].push((Game.new(row, stats_hash[row[0]])))
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
end
