require_relative './team'
require_relative './game'
require_relative './game_teams'
require_relative './game_teams_repository'
require_relative './team_repository'
require_relative './game_repository'

require 'CSV'

class StatTracker






  def self.from_csv(file_paths)

    team_repository = TeamRepository.new(file_paths[:teams])
    game_repository = GameRepository.new(file_paths[:games])
    game_team_repository = GameTeamsRepository.new(file_paths[:game_teams])
    stat_tracker = StatTracker.new(team_repository, game_repository, game_team_repository)

  end
    attr_reader :team_repository, :game_repository, :game_team_repository

  def initialize(team_repository, game_repository, game_team_repository)
    @team_repository = team_repository
    @game_repository = game_repository
    @game_team_repository = game_team_repository
  end

  def highest_total_score
    @game_repository.highest_total_score
  end

  def lowest_total_score
    @game_repository.lowest_total_score
  end


# @game_teams_path = game_teams_path

  #   def games(file_path)
  #     Game.from_csv(game_path)
  #     Game.all_games
  # end

  # def game_stats(file_path)
  #   GameStats.from_csv(file_path)
  #   game_stats = GameStats.all_game_stats
  #
  # end

  # def team_info(id)
  #   info_hash = Hash.new
  #
  #   Team.all_teams.each do |team|
  #     if team.team_id == id
  #     info_hash[:team_id] = team.team_id
  #     info_hash[:franchise_id] = team.franchiseid
  #     info_hash[:team_name] = team.teamname
  #     info_hash[:abbreviation] = team.abbreviation
  #     info_hash[:link] =  team.link
  #     end
  #   end
  #     info_hash
  # end
  def team_info(id)
    @team_repository.team_info(id)
  end




# Season with the highest win percentage for a team.
      # (win/total) *100

  def best_season(id)

    season_win_percent = Hash.new
    count = 0
    wins = Game.all_games.each do |game|

      if game.away_team_id == id && (game.away_goals > game.home_goals) && (season_win_percent[game.season] == nil)
         # && season_win_percent[game.season] == nil
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals) && (season_win_percent[game.season] == nil)
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.away_team_id == id && (game.away_goals > game.home_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      end
      # end
    end
    best_percent = season_win_percent.max_by do |key, value|
      season_win_percent[key]
    end
      best_percent.first


  end

  def games_per_season(id, game_season)
    games_per_season = 0
    Game.all_games.each do |game|

      if (game.away_team_id == id || (game.home_team_id == id)) && (game.season == game_season)
        games_per_season += 1
      end
    end
    games_per_season
  end

  def worst_season(id)
    season_win_percent = Hash.new
    count = 0
    wins = Game.all_games.each do |game|

      if game.away_team_id == id && (game.away_goals > game.home_goals) && (season_win_percent[game.season] == nil)
         # && season_win_percent[game.season] == nil
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals) && (season_win_percent[game.season] == nil)
        season_win_percent[game.season] = 0
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.away_team_id == id && (game.away_goals > game.home_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      elsif game.home_team_id == id && (game.home_goals > game.away_goals)
        season_win_percent[game.season] += (1.to_f/(games_per_season(id, game.season)))
      end
      # end
    end
    best_percent = season_win_percent.min_by do |key, value|
      season_win_percent[key]
    end
      best_percent.first

  end

  # average_win_percentage	Average win percentage of all games for a team.

  # def average_win_percentage(id)
  #   win_percent = 0
  #   GameStats.all_game_stats.each do |game|
  #     require"pry";binding.pry
  #     if (game.team_id == id) && (game.result == win)
  #       win_percent += (1)
  #     end
  #   end
  #   win
  #   end
  # =>




  end
