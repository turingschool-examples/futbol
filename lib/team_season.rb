require './spec/spec_helper'

class TeamSeason
  attr_accessor :goals,
                :games,
                :shots,
                :tackles,
                :home_games,
                :away_games,
                :home_goals,
                :away_goals,
                :season

  def initialize(season, team_id)
    @team_id = team_id
    @season = season
    @goals = 0
    @games = 0
    @shots = 0
    @tackles = 0
    @home_games = 0
    @away_games = 0
    @home_goals = 0
    @away_goals = 0
  end
end

