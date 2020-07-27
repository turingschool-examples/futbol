require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"
require "csv"

class TeamStatistics

  def initialize
    @team_info_by_id = Hash.new
    @by_team_id_game_objects = []
  end

  def all_teams
    TeamData.create_objects
  end

  def all_games
    GameData.create_objects
  end

  def all_game_teams
    GameTeamData.create_objects
  end

  def team_info(passed_id)
    all_teams.each do |team|
      if passed_id == team.team_id.to_s # Remove .to_s when spec harness info updates
        @team_info_by_id[:team_id] = team.team_id
        @team_info_by_id[:franchise_id] = team.franchise_id
        @team_info_by_id[:team_name] = team.team_name
        @team_info_by_id[:abbreviation] = team.abbreviation
        @team_info_by_id[:link] = team.link
      end
    end
    @team_info_by_id
  end

  def collect_game_objects_by_team_id(passed_id)
    all_games.each do |game_object|
      if game_object.home_team_id.to_s == passed_id
        @by_team_id_game_objects << game_object
      elsif game_object.away_team_id.to_s == passed_id
        @by_team_id_game_objects << game_object
      end
    end
  end

  def best_season(passed_id)
    collect_game_objects_by_team_id(passed_id)


    # hash key:season value:size of games played that season
    @total_games_by_season_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }

    @by_team_id_game_objects.each do |game|
      @total_games_by_season_by_team_id[game.season] += 1
    end

    # hash key:season value:wins that season
    @total_wins_by_season_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }

    @by_team_id_game_objects.each do |game|
      if passed_id == game.away_team_id.to_s && game.away_goals > game.home_goals
        @total_wins_by_season_by_team_id[game.season] += 1
      elsif passed_id == game.home_team_id.to_s && game.home_goals > game.away_goals
        @total_wins_by_season_by_team_id[game.season] += 1
      elsif passed_id == game.away_team_id.to_s && game.away_goals < game.home_goals
        @total_wins_by_season_by_team_id[game.season] += 0
      elsif passed_id == game.home_team_id.to_s && game.home_goals < game.away_goals
        @total_wins_by_season_by_team_id[game.season] += 0
      end
    end

    # Hash key:season value:avg win
    @win_percentage_by_season_by_team_id = Hash.new

    x = @total_games_by_season_by_team_id
    y = @total_wins_by_season_by_team_id


    @total_wins_by_season_by_team_id.each do |season, total_win|
      @win_percentage_by_season_by_team_id[season] = ((total_win.to_f / @total_games_by_season_by_team_id[season]) * 100).round(2)
    end

    best_season_print = @win_percentage_by_season_by_team_id.invert.max[1].to_s
    # worst_season_print = @win_percentage_by_season_by_team_id.invert.min[1].to_s

  end

end
