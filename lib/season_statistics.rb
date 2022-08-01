require './lib/stat_tracker'
require './lib/season_helper_module'
require './lib/team_name_by_id_helper_module'

class SeasonStatistics
  include Seasonable
  include TeamNameable

  def initialize(teams_data, games_data, game_teams_data)
    @teams_data = teams_data
    @games_data = games_data
    @game_teams_data = game_teams_data
  end

  def winningest_coach(season)
    records = coach_records(season)
    populate_coach_records(season, records)
    winning_record(records).max_by { |team, win_percent| win_percent }[0].to_s
  end

  def worst_coach(season)
    records = coach_records(season)
    populate_coach_records(season, records)
    winning_record(records).min_by { |team, win_percent| win_percent }[0].to_s
  end

  def most_accurate_team(season)
    records = accuracy_records(season)
    populate_accuracy_records(season, records)
    find_team_name_by_id(most_accurate(records))
  end

  def least_accurate_team(season)
    records = accuracy_records(season)
    populate_accuracy_records(season, records)
    find_team_name_by_id(least_accurate(records))
  end

  def most_tackles(season)
    records = tackle_records(season)
    populate_tackle_records(season, records)
    find_team_name_by_id(best_tackling_team(records))
  end

  def fewest_tackles(season)
    records = tackle_records(season)
    populate_tackle_records(season, records)
    find_team_name_by_id(worst_tackling_team(records))
  end
end