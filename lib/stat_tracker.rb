require "csv"
class StatTracker
	attr_reader :game_teams,
              :games,
              :teams

	def initialize
    @game_teams = Hash.new
    @games = Hash.new
    @teams = Hash.new
	end
  
	def self.from_csv(locations)
    stat_tracker = new 
    teams_csv_reader(locations, stat_tracker)
    games_csv_reader(locations, stat_tracker)
    game_teams_csv_reader(locations, stat_tracker)

    stat_tracker
  end

  def self.teams_csv_reader(locations, stat_tracker)
    contents = CSV.open locations[:teams], headers: true, header_converters: :symbol
    contents.each do |row|
    require 'pry'; binding.pry
    end
  end

  def self.games_csv_reader(locations, stat_tracker)
    contents = CSV.open locations[:games], headers: true, header_converters: :symbol
  end

  def self.game_teams_csv_reader(locations, stat_tracker)
    contents = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
  end
end