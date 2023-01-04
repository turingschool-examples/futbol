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
   end

  def percentage_home_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "home" && row[:result] == "WIN") || (row[:hoa] == "away" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "WIN") || (row[:hoa] == "home" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    tally = 0 
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "TIE") || (row[:hoa] == "home" && row[:result] == "TIE")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end


end






























