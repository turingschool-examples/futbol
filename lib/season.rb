require_relative './game'

class Season
  attr_reader :year,
              :games,
              :teams

  def initialize(year, team_refs, game_refs)
    @year = year
    @teams = team_refs
    @games = game_refs
  end
end
