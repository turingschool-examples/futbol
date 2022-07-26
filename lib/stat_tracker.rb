require 'csv'
require 'pry'

class StatTracker
 attr_reader :filepath

def initialize(locations)
#  @filepath = filepath
end

# def self.from_csv(locations)
 
# end

# def initialize(filepath)
# #   @data = CSV.read(filepath, headers: true,
# # header_converters: :symbol)
# end

  def self.from_csv(locations)
    games_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(locations)
  end
    # binding.pry
    # locations.find do |location|
    #   p location
    # @contents.each do |row|
    #   name = row[2]
    # puts name
    # binding.pry
    # games = CSV.open(locations[:games], headers: true, header_converters: :symbol)
    # teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
    # game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)


  def teams
   contents = CSV.open "data/teams.csv", headers: true, header_converters: :symbol
   list = {}
   contents.each do |row|
    name = row[:teamname]
    id = row[:team_id]
    list[name] = id
   end
   p list
  end
  

end