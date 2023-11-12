require 'CSV'
require_relative './game_team'

class GameTeamList
  attr_reader :game_teams, :stat_tracker

  def initialize(path, stat_tracker)
    # pluralized create_game_teams and rearranged initialized order for consistancy
    @game_teams = create_game_teams(path)
    @stat_tracker = stat_tracker
  end

    # updated method name to match the format of the other classes
  def create_game_teams(path)
    # removed the array append method because the .map creates an array
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |datum|
        GameTeam.new(datum,self)
    end
  end

end