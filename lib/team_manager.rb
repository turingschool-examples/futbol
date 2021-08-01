require_relative './team'
require_relative './game_manager'
require_relative './game'

class TeamManager
  attr_reader :teams

  def initialize(locations)
    @teams = Team.read_file(locations[:teams])
    @games = Game.read_file(locations[:games])
    @game_manager = GameManager.new(locations)
    @game_team_manager = GameTeamManager.new(locations)

  end
  #
  def team_by_id(id)
    team_return = @teams.find do |team|
       team.team_id == id
     end
     team_return
  end

  def team_info(id)
    team = team_by_id(id)
    {
      team_id: id,
      franchise_id: team.franchise_id,
      team_name: team.team_name,
      abbreviation: team.abbreviation,
      link: team.link
    }
  end



  def win_percentage(id, games)

    total_wins = @game_manager.games_by_team_id(id).count do |game|
      game.home_team_id == id && game.home_goals > game.away_goals || game.away_team_id == id && game.away_goals > game.home_goals
    end
    # total_wins = games.map do |game|
    #   @game_team_manager.by_team_and_game_id(id, game.game_id).result.sum do |game_team|
    #      game_team.result == "WIN"
    #   end
    # #   require "pry";binding.pry
    # end
    total_wins.fdiv(games.count) * 100.0
  end
    # require "pry";binding.pry



  # def team_info(team_id)
  #   find_team = @teams.find do |team|
  #     team.team_id == team_id
  #   end
  #   team_info = {
  #     team_id: find_team.team_id,
  #     franchise_id:  find_team.franchise_id,
  #     team_name:  find_team.team_name,
  #     abbreviation: find_team.abbreviation,
  #     link:  find_team.link
  #   }
  # end
end
