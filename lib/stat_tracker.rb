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

  def count_of_games_by_season
  
    count_of_games_by_season = Hash.new(0)
     seasons = @games.map { |row| row[:season]}.tally
    #  @games.each do |row|
     #end
    
    #  seasons.uniq.each do |season|
    #  end
  

    # count_of_games_by_season[:season]
    # count_of_games_by_season[@games.count]
    # count_of_games_by_season
    # @games.map {|row| row[:season]}
   

    # count_of_games_by_season[:season] = 
    # location[:season]
    # keys = season 
    # @stat_tracker.games.count
    # values = count_of_games #7442?
    # @games.count


  end


end






























