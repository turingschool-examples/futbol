require_relative './game_team'

class GameTeamManager
  attr_reader :game_teams

  def initialize(locations)
    @game_teams = GameTeam.read_file(locations[:game_teams])
  end

  def by_game_id(id)
    @game_teams.filter do |game_team|
      game_team.game_id == id
    end
  end

  # def by_team_and_game_id(team_id, game_id)
  #   @game_teams.find do |game_team|
  #     game_team.game_id == game_id && game_team.team_id == team_id
  #   end
  # end


end
