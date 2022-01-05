require 'csv'

class GameStatistics
  attr_reader :files

  def initialize(files)
    @files = files
    @games_file = CSV.readlines files[:games], headers: true, header_converters: :symbol
    @teams_file= files[:teams]
    @games_by_team = files[:game_stats]
  end

  def highest_total_score
    scores = @games_file.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    hts = scores.max
    index_array = []
    scores.each_with_index do |score,index|
      index_array << index if score == hts
    end
    @games_file.each_with_index do |row, index|
      index_array.select do |score_index|
        puts "#{row} #{hts}" if score_index == index
      end
    end
    hts
  end
end
