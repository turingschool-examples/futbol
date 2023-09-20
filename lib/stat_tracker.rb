require "csv"
class StatTracker

  
  def self.from_csv(locations)
    content = {}
    content[:teams] = CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    content[:games] = CSV.read(locations[:games], headers: true, header_converters: :symbol),
    content[:game_teams] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  
  end
##in pry you can then do stat_tracker[:team_id] and it will print stuff
end