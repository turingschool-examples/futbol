require 'csv'
class StatTracker
    attr_reader :game_path,
                :team_path,
                :game_teams_path

    def initialize(locations)
        @game_path = CSV.read(locations[:games], headers: true, header_converters: :symbol)
        @team_path = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
        @game_teams_path = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    end

    def self.from_csv(locations)
       StatTracker.new(locations)
    end

end