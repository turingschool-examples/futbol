require_relative "stat_tracker"

class SeasonStatistics
  attr_reader :stat_tracker_copy
  def initialize(stat_tracker)
    @csv_game_teams_table = stat_tracker.game_teams
    @csv_games_table = stat_tracker.games
    @stat_tracker_copy = stat_tracker
    @season_coach_hash = coach_game_results
  end

  def map_season_to_game_ids
    season_game_id_hash = {}
    @csv_games_table.each do |game_id, game|
      season_game_id_hash[game_id] = game.season
    end
    season_game_id_hash
  end

  def find_all_seasons
    seasons = []
    @csv_games_table.each do |game_id, game|
      if !seasons.include?(game.season)
        seasons << game.season
      end
    end
    seasons
  end

  def coach_game_results
    seasons = find_all_seasons
    season_game_id_hash = map_season_to_game_ids
    season_coach_hash = {}

    seasons.each do |season|
      coach_results_hash = {}
      @csv_game_teams_table.each do |game_id, game_team|
        if season_game_id_hash[game_id] == season
          if coach_results_hash[game_team.head_coach]
            coach_results_hash[game_team.head_coach] << game_team.result
          else
            coach_results_hash[game_team.head_coach] = [game_team.result]
          end
        end
      end
      season_coach_hash[season] = coach_results_hash
    end
    season_coach_hash
  end

  def winningest_coach(season)
    winningest_coach_name = nil
    highest_percentage = 0
    @season_coach_hash[season].each do |key, value|
      total_games = 0
      total_wins = 0
      total_losses = 0
      total_ties = 0
      value.each do |game_result|
        total_games += 1
        if game_result == "WIN"
          total_wins += 1
        elsif game_result == "LOSS"
          total_losses += 1
        elsif game_result == "TIE"
          total_ties += 1
        end
      end
      # p " #{key} +  #{(total_wins.to_f / total_games).round(2)}"
      if (total_wins.to_f / total_games) > highest_percentage
        highest_percentage = (total_wins.to_f / total_games)
        winningest_coach_name = key
        # require "pry"; binding.pry/
      end
    end
    @stat_tracker_copy.winningest_coach = winningest_coach_name
  end

end
