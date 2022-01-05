require 'csv'
require './lib/game'
require './lib/season'
require './lib/team_tracker'

class GameTracker
  attr_reader :games, :path

  def initialize(path)
    @@games = create(path)
    @path = path
  end

  def create(path)
    games = []
    contents = CSV.open "#{path}", headers:true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      season = row[:season]
      games << Game.new(game_id,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link,season)
    end
    games
  end

    def highest_total_score
      total_scores = []
      @contents.each do |row|
        score =  row[:away_goals].to_i + row[:home_goals].to_i
        total_scores << score
      end
      total_scores.max
    end


  #   def lowest_total_score
  #     total_scores = []
  #     @contents.each do |row|
  #       score =  row[:away_goals].to_i + row[:home_goals].to_i
  #       total_scores << score
  #     end
  #     total_scores.min
  #   end
  #
  #   def percentage_home_wins
  #     total_games = 0
  #     home_wins = 0
  #     @contents.each do |row|
  #       total_games += 1
  #       row[:home_goals].to_i > row[:away_goals].to_i ? home_wins += 1 : next
  #     end
  #     ((home_wins.to_f / total_games) * 100).round(2)
  #   end
  #
  #   def percentage_vistor_wins
  #     total_games = 0
  #     visitor_wins = 0
  #     @contents.each do |row|
  #       total_games += 1
  #       row[:home_goals].to_i < row[:away_goals].to_i ? visitor_wins += 1 : next
  #     end
  #     ((visitor_wins.to_f / total_games) * 100).round(2)
  #   end
  #
  #   def percentage_ties
  #     total_games = 0
  #     ties = 0
  #     @contents.each do |row|
  #       total_games += 1
  #       row[:home_goals].to_i == row[:away_goals].to_i ? ties += 1 : next
  #     end
  #     ((ties.to_f / total_games) * 100).round(2)
  #   end
  #
  #   def count_of_games_by_season
  #     game_count = Hash.new(0)
  #     @contents.each do |row|
  #       game_count[row[:season]] += 1
  #     end
  #     game_count
  #   end
  #
  #   def average_goals_per_game
  #     total_games = 0
  #     total_scores = 0
  #     @contents.each do |row|
  #       total_games += 1
  #       total_scores += (row[:home_goals].to_i + row[:away_goals].to_i)
  #     end
  #     (total_scores.to_f / total_games).round(2)
  #   end
  #
  #   # def average_goals_by_season
  #   #   # want key value pair to give total number of games, then want total number of goals. Will then return hash that has season name with the value of average goals
  #   #   season_games = count_of_games_by_season
  #   #   require "pry"; binding.pry
  #   #
  #   #     @contents.each do |row|
  #   #       # count_of_games_by_season[pair[0]]=((row[:home_goals].to_f + row[:away_goals].to_f) / pair[1])
  #   #     end
  #   #   end
  #   # end
  #
  # end
end
