require "csv"
class StatTracker
  attr_reader :teams,
              :games,
              :game_teams

  def initialize(content)
    @teams = content[:teams]
    @games = content[:games]
    @game_teams = content[:game_teams]
  end
  
  def self.from_csv(locations)
    # content = {}
    # content[:teams] = CSV.readlines(locations[:teams], headers: true, header_converters: :symbol),
    # content[:games] = CSV.readlines(locations[:games], headers: true, header_converters: :symbol),
    # content[:game_teams] = CSV.readlines(locations[:game_teams], headers: true, header_converters: :symbol)  
    StatTracker.new(locations)
  end

  def highest_total_score
    hash = Hash.new{ |hash,key| hash[key] = [] }
    @game_teams.each do |game|
      key = game[0].to_i 
      value = game[6].to_i 
      hash[key] << value
    end
    sums = hash.values.map do |pair|
      pair.sum
    end
    sums.max
  end
##in pry you can then do stat_tracker[:team_id] and it will print stuff
end