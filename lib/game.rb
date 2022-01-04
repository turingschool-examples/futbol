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

  def percentage_home_wins
    total_games = 0
    home_wins = 0
    @contents.each do |row|
      total_games += 1
      row[:home_goals].to_i > row[:away_goals].to_i ? home_wins += 1 : next
    end
    ((home_wins.to_f / total_games) * 100).round(2)
  end

  def percentage_vistor_wins
    total_games = 0
    visitor_wins = 0
    @contents.each do |row|
      total_games += 1
      row[:home_goals].to_i < row[:away_goals].to_i ? visitor_wins += 1 : next
    end
    ((visitor_wins.to_f / total_games) * 100).round(2)
  end

  def percentage_ties
    total_games = 0
    ties = 0
    @contents.each do |row|
      total_games += 1
      row[:home_goals].to_i == row[:away_goals].to_i ? ties += 1 : next
    end
    ((ties.to_f / total_games) * 100).round(2)
  end

  def count_of_games_by_season
    game_count = Hash.new(0)
    @contents.each do |row|
      game_count[row[:season]] += 1
    end
    game_count
  end

  def average_goals_per_game
    total_games = 0
    total_scores = 0
    @contents.each do |row|
      total_games += 1
      total_scores += (row[:home_goals].to_i + row[:away_goals].to_i)
    end
    (total_scores.to_f / total_games).round(2)
  end

  def average_goals_by_season
    # want key value pair to give total number of games, then want total number of goals. Will then return hash that has season name with the value of average goals
    season_games = count_of_games_by_season
    require "pry"; binding.pry
    
      @contents.each do |row|
        # count_of_games_by_season[pair[0]]=((row[:home_goals].to_f + row[:away_goals].to_f) / pair[1])
      end
    end
  end

end
