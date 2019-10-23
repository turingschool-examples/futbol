require 'csv'
require_relative 'game'

class GameStatCollection

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
  end

  def all_stats
    csv = CSV.read '#{@csv_file_path}', headers: true, header_converters: :symbols
    csv.map do |row|
      Game.new(row)
    end
  end
end
