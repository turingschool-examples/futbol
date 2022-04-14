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

def percentage_visitor_wins
  total_games = @games[:game_id].count.to_f
  visitor_wins = 0
  @games.each { |row| visitor_wins += 1 if row[:home_goals].to_i < row[:away_goals].to_i }
  decimal = (visitor_wins.to_f / total_games)
  (decimal * 100).round(2)
end

def percentage_ties
  total_games = @games[:game_id].count.to_f
  number_tied = 0
  @games.each { |row| number_tied += 1 if row[:home_goals].to_i == row[:away_goals].to_i }
  decimal = (number_tied.to_f / total_games)
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


























































































# T H I A G O O O O O O O A L L L L L
  def winningest_coach
    # require 'pry'; binding.pry
    results = @game_teams[:result]
    coaches = @game_teams[:head_coach]
    unique_coaches = coaches.uniq

    win_list = Hash.new(0)
    # require 'pry'; binding.pry

    coach_result = coaches.zip(results)
    win_results = []
    coach_result.each do |g|
      win_results << g if g.include?("WIN")
    end

    unique_coaches.each do |coach|
      win_results.each do |win|
        if coach == win[0] && win_list[coach] == nil
          win_list[coach] = 1
        elsif coach == win[0] && win_list[coach] != nil
          win_list[coach] += 1
        end
      end
    end
    # require 'pry';binding.pry
    win_list.key(win_list.values.max)


    # coaches.each do |coach|
    #   results.each do |result|
    #     if win_list[:coach] == nil && result == "WIN"
    #       win_list[:coach] += 1
    #   end
    # end
    #
    # coaches.each do |coach|
    #   if result.includes?("WIN")
    #     coach_win_list << coach
    #   elsif result.includes?("LOSS")
    #     coach_lose_list << coach
    #   end
    # end
    # results = []
    # coach_wins_list = []
    # coach_lose_list = []
    #
    # # results.each do |result|
    # #   results << result
    # # end
    #
    # coaches.each do |coach|
    #   if result.includes?("WIN")
    #     coach_win_list << coach
    #   elsif result.includes?("LOSS")
    #     coach_lose_list << coach
    #   end
    # end
  end
# This method should take a season id as an argument and return the values described below.
#
# Method: winningest_coach
# Description: Name of the Coach with the best win percentage for the season
# Return Value: String




































#STEPHEN



































































































end
