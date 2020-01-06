require_relative './calculateable'
require_relative './gatherable'

module SeasonStats
  include Calculateable
  include Gatherable

  def biggest_bust(season_id)
    regular = team_regular_season_record(season_id)
    post = team_postseason_record(season_id)
    require 'pry'; binding.pry
    biggest_difference = win_percentage_difference(regular, post)
    require 'pry'; binding.pry
    team_id = biggest_difference.max_by { |k, v| v }[0]
    get_team_name_by_id(team_id)
  end

  def biggest_surprise(season_id)
    regular = team_regular_season_record(season_id)
    post = team_postseason_record(season_id)
    biggest_increase = win_percentage_increase(regular, post)
    team_id = biggest_increase.max_by { |k, v| v }[0]
    get_team_name_by_id(team_id)
  end
end
