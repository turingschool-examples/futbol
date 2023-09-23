require './spec/spec_helper'

class TeamSeason
  attr_accessor :goals,
                :games,
                :shots,
                :tackles,
                :home_games,
                :away_games,
                :home_scores,
                :away_scores
  def initialize(season, team_id)
    @team_id = team_id
    @season = season
    @goals = 0
    @games = 0
    @shots = 0
    @tackles = 0
    @home_games = 0
    @away_games = 0
    @home_scores = 0
    @away_scores = 0
  end
end

