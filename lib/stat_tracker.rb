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

  def lowest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.min
  end

  def count_of_teams
   @teams.count
  end

  def nested_hash_creator
    Hash.new {|h,k| h[k] = Hash.new(0) }
  end

def team_id_to_name(id)
  @teams.find { |team| team[:team_id] == id }[:teamname]
end




 

  


end






























