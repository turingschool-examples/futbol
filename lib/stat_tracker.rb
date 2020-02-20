require 'CSV'

class StatTracker

  def self.from_csv(locations)
    all_game_info = {}
    all_game_info[:teams_csv] = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    all_game_info[:game_teams_csv] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    all_game_info[:games_csv] = CSV.read(locations[:games], headers: true, header_converters: :symbol)

    StatTracker.new(all_game_info)
  end

    def initialize(all_game_info)
      @games_csv = all_game_info[:teams_csv]
      @teams_csv = all_game_info[:game_teams_csv]
      @game_teams_csv = all_game_info[:games_csv]
    end
end
