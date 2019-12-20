class GameTeams

  attr_reader :hoa, :result

  def initialize(game_teams_info)
    @hoa = game_teams_info[:hoa]
    @result = game_teams_info[:result]
  end
end
# require "pry"; binding.pry
