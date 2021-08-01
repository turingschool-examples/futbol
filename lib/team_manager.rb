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

  def best_season(id)
    season_games = @game_manager.games_by_team_id(id).group_by do |game|
      game.season
    end

    season_games.max_by do |season_games|
      win_percentage(id, season_games)
    end.flatten[0]
  end

  def win_percentage(id, games)

    total_wins = @game_manager.games_by_team_id(id).count do |game|
      game.home_team_id == id && game.home_goals > game.away_goals || game.away_team_id == id && game.away_goals > game.home_goals
    end
    (total_wins.fdiv(games.count) * 100.0).round(1)
  end



end
