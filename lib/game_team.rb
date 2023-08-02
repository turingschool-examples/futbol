require_relative 'helper_class'

class GameTeam
  @@game_teams = []
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :coach,
              :goals,
              :shots,
              :tackles

  def initialize(game_team_file)
    @game_id = game_team_file[:game_id]
    @team_id = game_team_file[:team_id]
    @hoa = game_team_file[:hoa]
    @result = game_team_file[:result]
    @coach = game_team_file[:head_coach]
    @goals = game_team_file[:goals]
    @shots = game_team_file[:shots]
    @tackles = game_team_file[:tackles]
    @@game_teams << self
  end

  def self.game_teams
    @@game_teams
  end
end