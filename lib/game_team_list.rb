require 'CSV'
require_relative './game_team'

class GameTeamList
  attr_reader :game_teams, :stat_tracker

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams = create_game_team_list(path)
  end

    def create_game_team_list(path)
        arr = []
        data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
        data.map do |datum|
            arr.append(GameTeam.new(datum,self))
        end
        arr
    end
end
