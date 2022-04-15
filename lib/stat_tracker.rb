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
    (goals.sum / goals.count).round(2)
  end

  def average_goals_by_season
    average_by_season = {}
    season_hash = @games.group_by { |row| row[:season].itself }
    season_hash.each do |season, games|
      counter = 0
      game = 0
      games.each do |key|
        counter += (key[:away_goals].to_i + key[:home_goals].to_i)
        game += 1
      end
        average_by_season.merge!(season => (counter.to_f/game.to_f).round(2))
    end
    average_by_season
  end

























































































# T H I A G O O O O O O O A L L L L L
  def winningest_coach#.(season) not implemented yet
    results = @game_teams[:result]
    coaches = @game_teams[:head_coach]
    unique_coaches = coaches.uniq

    win_list = Hash.new(0)

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
    win_list.key(win_list.values.max)
  

  end


def worst_coach
  results = @game_teams[:result]
  coaches = @game_teams[:head_coach]
  unique_coaches = coaches.uniq

  loss_list = Hash.new(0)

  coach_result = coaches.zip(results)
  loss_results = []
  coach_result.each do |g|
    loss_results << g if g.include?("LOSS")
  end


  unique_coaches.each do |coach|
    loss_results.each do |loss|
      if coach == loss[0] && loss_list[coach] == nil
        loss_list[coach] = 1
      elsif coach == loss[0] && loss_list[coach] != nil
        loss_list[coach] += 1
      end
    end
  end
  loss_list.key(loss_list.values.min)
end



 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  #stephen



































































































end
