require 'parsable'
class SeasonStats
  include Parsable
  attr_reader :games, :teams, :game_teams

  def initialize(location)
    @games = location[:games]
    @teams = location[:teams]
    @game_teams = location[:game_teams]
  end

  def method_name

  end

end
