require './lib/stat_tracker'
require './lib/season_helper_module'
require './lib/team_name_by_id_helper_module'

class SeasonStatistics
  include Seasonable
  include TeamNameable

  attr_reader :season

  def initialize(locations)
    @season = season
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    SeasonStatistics.new(locations)
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