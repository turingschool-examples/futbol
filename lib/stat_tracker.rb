require 'csv'

class StatTracker

    def self.from_csv(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

end