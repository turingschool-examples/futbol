require 'csv'
require 'pry'

class StatHelper
  # Was line 307 in stat_tracker
  # Helper method is used in:
  # 1. game_wins_by_season (coach_status_by_season (winningest_coach & worst_coach)),
  # 2. total_games_by_coaches_by_season(coach_status_by_season (winningest_coach & worst_coach)),
  # 3. tackles_by_team (most_tackles, fewest_tackles)
  # 4. games_by_team_by_season (best_season, worst_season)

  def games_by_season
    @games_by_season_hash = Hash.new([])
    @games.each do |game|
      @games_by_season_hash[game[:season]] += [game[:game_id]]
    end
    @games_by_season_hash
  end

  def games_by_season_save
    @games_by_season_hash
  end
end