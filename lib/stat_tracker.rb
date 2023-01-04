require 'csv'

class StatTracker
  attr_reader :data_array,
              :games,
              :teams,
              :game_teams


  def self.from_csv(locations)
    @data_array = locations.values.map {|location| location }
    @stat_tracker = StatTracker.new(@data_array)
  end

  def initialize(data_array)
    @data_array = data_array
    @games = CSV.read @data_array[0], headers: true, header_converters: :symbol
    @teams = CSV.read @data_array[1], headers: true, header_converters: :symbol
    @game_teams = CSV.read @data_array[2], headers: true, header_converters: :symbol
  end

  def highest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.max
  end

  def average_goals_per_game
    total_games = @games.map { |row| row[:game_id]}.count
    total_goals = @games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i}.sum
    (total_goals.to_f / total_games).round(2)
  end

  def average_goals_by_season
    # average_goals_by_season = {}
    # goal_amounts = []
    # all_seasons = @games.map { |row| row[:season]}
    #   all_seasons.uniq.each do |season|
    #     @games.each do |row| 
    #       if row[:season] == season 
    #         goals = row[:home_goals].to_i + row[:away_goals].to_i
    #         goal_amounts << goals
    #         # require 'pry'; binding.pry
    #   end
    # end 
    # all_seasons.uniq.each do |season|
    #   average_goals_by_season[season] = goal_amounts.sum
    # # require 'pry'; binding.pry
    #  average_goals_by_season 
    #   end
    # end
  end 

end






























