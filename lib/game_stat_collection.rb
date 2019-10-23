require 'csv'
require_relative 'game'
require_relative 'stat_tracker'

class GameStatCollection
  attr_reader :game_instances

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @game_instances = all_stats
  end

  def all_stats
    game_objects = []
    csv = CSV.read("#{@csv_file_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
      game_objects <<  Game.new(row)
    end
    game_objects
  end
end
