require 'csv'
require './lib/stat_tracker'
require 'pry'

class StatTracker
  attr_reader :all_data
  
  def initialize(all_data)
    @all_data = all_data
  end

  def self.from_csv(locations)
    all_data = {}
    locations.each do |file_name, location|
      formatted_csv = CSV.open location, headers: true, header_converters: :symbol
      all_data[file_name] = formatted_csv
    end
    StatTracker.new(all_data)
  end

  def dummy_method
    @all_data[:game_team_f].each do |row|
      name = row[:game_id]
      puts "#{name}"
    end
  end

  def highest_total_score
    game_ids_list = @all_data[:game_team_f].map{|row| row[:game_id]}.uniq.sort
    data_list = {}
    ## Separating list to return only Game ID, Goals as a HASH
    @all_data[:game_team_f].each do |row|
      game_id = row[:game_id]
      goals = row[:goals]
      data_list[game_id]=goals
      require'pry';binding.pry
    end
    ##iterate through all games. if gameid1 = gameid2, add gameid1 + gameid2
    data_list
  end
## SUM the total score for the teams

## if team A scores 10 goals and Team B scores 9 goals then total_score is 19

## Calculate this for every game that is played

## which team has the highest total score?
end