require 'csv'
class Game
  def initialize(path)
    @path = path
    @contents = CSV.open "#{path}", headers:true, header_converters: :symbol

  end

  def highest_total_score
    total_scores = []
    @contents.each do |row|
      score =  row[:away_goals].to_i + row[:home_goals].to_i
      total_scores << score
    end
    total_scores.max
  end


  def lowest_total_score
    total_scores = []
    @contents.each do |row|
      score =  row[:away_goals].to_i + row[:home_goals].to_i
      total_scores << score
    end
    total_scores.min
  end
end
