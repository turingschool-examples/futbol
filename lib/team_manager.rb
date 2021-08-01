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
    #we will refactor this with sort_by.
    season_games.max_by do |season, season_games|
      win_percentage(id, season_games)
    end.flatten[0]
  end

  def worst_season(id)
    season_games = @game_manager.games_by_team_id(id).group_by do |game|
      game.season
    end

    #we will refactor this with sort_by.
    season_games.min_by do |season, season_games|
      win_percentage(id, season_games)
    end.flatten[0]
  end

  def win_percentage(id, games)
    total_wins = @game_manager.games_by_team_id(id).count do |game|
      game.home_team_id == id && game.home_goals > game.away_goals || game.away_team_id == id && game.away_goals > game.home_goals
    end
    (total_wins.fdiv(games.count) * 100.0).round(1)
  end

  def average_win_percentage(id)
    win_percentage(id, @game_manager.games_by_team_id(id))
  end

  def all_goals_by_team(id)
    @game_manager.games_by_team_id(id).filter_map do |game|
      game.home_goals if game.home_team_id == id || game.away_goals if game.away_team_id == id
    end.uniq
  end

  def most_goals_scored(id)
    all_goals_by_team(id).max.to_i
  end

  def fewest_goals_scored(id)
    all_goals_by_team(id).min.to_i
  end

  def games_against_opponents(id)
    @game_manager.games_by_team_id(id).group_by do |game|
      if game.home_team_id == id
        game.away_team_id
      elsif game.away_team_id == id
        game.home_team_id
      end
    end
  end

  def favorite_opponent(id)
    opponent = games_against_opponents(id).max_by do |id, game|
      win_percentage(id, game)
    end.flatten[0]

    team_var = @teams.find do |team|
      team.team_id == opponent
    end

    team_var.team_name
  end
end

  #the key is '@game_manager.games_by_team_id(id)'

    # value = []
    # value << if @game_manager.games_by_team_id(id).include?(key)
    #   require "pry"; binding.pry
    # end

    # teams = @game_manager.games_by_team_id(id).group_by do |game|
    #   id if game.home_team_id == id || id  if game.away_team_id == id
    # end
    # require "pry"; binding.pry
    # teams




    # @game_manager.games_by_team_id(id).map do |game|
    #   game.home_goals if game.home_team_id == id || game.away_goals if game.away_team_id == id
    # end.uniq

    #iterate thru the games w max_by and match the id to home or away team id
    #if id == home_team_id look at home goals
    #else id == away_team_id look at away goals
