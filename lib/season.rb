require_relative './calculator'

class Season
  include Calculator
  attr_reader :result

  def initialize(season_id, hash_method, math_method, parent)
    @parent = parent
    @game_set = @parent.game_teams_by_season(season_id)
    @result = (send(math_method, send(hash_method))).first
  end

  def teams_with_tackles
    @game_set.each_with_object(Hash.new(0)) do |game_team, teams|
        teams[game_team.team_id] += game_team.tackles
    end
  end
end
