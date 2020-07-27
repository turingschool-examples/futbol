require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"
require "csv"

class TeamStatistics

  def initialize
    @team_info_by_id = Hash.new
    @by_team_id_game_objects = []
    @total_games_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_wins_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    @win_percentage_by_season = Hash.new
    @games_won_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @goals_by_game = []
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

  def total_games_by_season_by_team_id
    @by_team_id_game_objects.each do |game|
      @total_games_by_season[game.season] += 1
    end
  end

  def total_wins_by_season_by_team_id(passed_id)
    @by_team_id_game_objects.each do |game|
      if passed_id == game.away_team_id.to_s && game.away_goals > game.home_goals
        @total_wins_by_season[game.season] += 1
      elsif passed_id == game.home_team_id.to_s && game.home_goals > game.away_goals
        @total_wins_by_season[game.season] += 1
      elsif passed_id == game.away_team_id.to_s && game.away_goals < game.home_goals
        @total_wins_by_season[game.season] += 0
      elsif passed_id == game.home_team_id.to_s && game.home_goals < game.away_goals
        @total_wins_by_season[game.season] += 0
      end
    end
  end

  def win_percentage_by_season_by_team_id
    @total_wins_by_season.each do |season, total_win|
      @win_percentage_by_season[season] = ((total_win.to_f / @total_games_by_season[season]) * 100).round(2)
    end
  end

  def best_and_worst_season_suite(passed_id)
    collect_game_objects_by_team_id(passed_id)
    total_games_by_season_by_team_id
    total_wins_by_season_by_team_id(passed_id)
    win_percentage_by_season_by_team_id
  end

  def best_season(passed_id)
    best_and_worst_season_suite(passed_id)
    @win_percentage_by_season.invert.max[1].to_s
  end

  def worst_season(passed_id)
    best_and_worst_season_suite(passed_id)
    @win_percentage_by_season.invert.min[1].to_s
  end

  def sort_games_won_by_team_id(passed_id)
    @by_team_id_game_objects.each do |game|
      if passed_id == game.away_team_id.to_s && game.away_goals > game.home_goals
        @games_won_by_team_id[game.away_team_id.to_s] += 1
      elsif passed_id == game.home_team_id.to_s && game.home_goals > game.away_goals
        @games_won_by_team_id[game.home_team_id.to_s] += 1
      elsif passed_id == game.away_team_id.to_s && game.away_goals < game.home_goals
        @games_won_by_team_id[game.away_team_id.to_s] += 0
      elsif passed_id == game.home_team_id.to_s && game.home_goals < game.away_goals
        @games_won_by_team_id[game.home_team_id.to_s] += 0
      end
    end
  end

  def average_win_suite(passed_id)
    collect_game_objects_by_team_id(passed_id)
    @total_games_played = @by_team_id_game_objects.size
    sort_games_won_by_team_id(passed_id)
    @games_won_by_team = @games_won_by_team_id.values[0].to_f
  end

  def average_win_percentage(passed_id)
    average_win_suite(passed_id)
    (@games_won_by_team / @total_games_played).round(2)
  end

  def goals_by_game_by_team(passed_id)
    @by_team_id_game_objects.each do |game|
      if passed_id == game.away_team_id.to_s
        @goals_by_game << game.away_goals
      elsif passed_id == game.home_team_id.to_s
        @goals_by_game << game.home_goals
      end
    end
  end

  def most_goals_scored(passed_id)
    collect_game_objects_by_team_id(passed_id)
    goals_by_game_by_team(passed_id)
    @goals_by_game.max
  end

  def fewest_goals_scored(passed_id)
    collect_game_objects_by_team_id(passed_id)
    goals_by_game_by_team(passed_id)
    @goals_by_game.min
  end


end
