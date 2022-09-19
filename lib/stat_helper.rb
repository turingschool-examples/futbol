require 'csv'
require 'pry'

# Class was made as parent class (vice module) for grading, as both were needed. Only helper methods were moved here for two reasons: 1. helper methods require no change to spec_harness and 2. moving helper methods used across multiple modules will let us create a vrb after its fist use that can be passed into a stub to reduce test time (module can't store the class vrb).
# This does break the 'is-a' convention.
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

  # Used for Stub to spec_helper on worst_season(line 115), winningest_coach(line 139), worst_coach(line 146), most_tackles(line 162), & fewest_tackles(line 168).
  # allow(@stat_tracker).to receive(:games_by_season).and_return(:games_by_season_save)
  def games_by_season_save
    @games_by_season_hash
  end

    # Helper method is used in average_scores_for_all_visitors & average_scores_for_all_home_teams
  def average_score_per_game(game_teams_selection)
    goals = game_teams_selection.sum {|game| game[:goals].to_f}
    # You need to / 2. The game_teams CSV has 2 lines to represent one game.
    games = (game_teams_selection.length.to_f/2.0)
    goals / games
  end
end