require 'CSV'
class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(data1, data2, data3)
    @teams = data2
    @games = data1
    @game_teams = data3
  end

  def self.from_csv(locations)
    data = []
    locations.values.each do |location|
      contents = CSV.read "#{location}", headers: true, header_converters: :symbol
      data << contents
      end
      StatTracker.new(data[0], data[1], data[2])
  end

  def highest_total_score
    sum = []
    @games.each do |row|
      i = row[:away_goals].to_i + row[:home_goals].to_i
      sum << i
    end
    sum.max
  end

  def lowest_total_score
    sum = []
    @games.each do |row|
      i = row[:away_goals].to_i + row[:home_goals].to_i
      sum << i
    end
    sum.min
  end































































#SAI
def percentage_home_wins
  total_games = @games[:game_id].count.to_f
  home_wins = 0
  @games.each { |row| home_wins += 1 if row[:home_goals].to_i > row[:away_goals].to_i }
  decimal = (home_wins.to_f / total_games)
  (decimal * 100).round(2)
end

































































































#COLIN
def average_goals_per_game
  goals = []
  @games.each do |row|
    i = row[:away_goals].to_f + row[:home_goals].to_f
    goals << i
  end
  # require 'pry'; binding.pry
  (goals.sum / goals.count).round(2)
end


































































































#THIAGO



































































































#STEPHEN



































































































end
