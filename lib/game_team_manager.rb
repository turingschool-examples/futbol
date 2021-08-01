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

  def winning_coach(id)
    winner = by_game_id(id).find do |game_team|
        game_team.result == "WIN"
      end
    winner.head_coach
  end

  def winning_coaches(season_game_ids)
    season_game_ids.map do |game|
      winning_coach(game)
    end
  end
end
