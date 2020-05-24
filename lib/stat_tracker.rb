require "csv"

class StatTracker

  def self.from_csv(locations_information)
    @games = locations_information[:games]
    @teams = locations_information[:teams]
    @game_teams = locations_information[:game_teams]
    self
  end

end
