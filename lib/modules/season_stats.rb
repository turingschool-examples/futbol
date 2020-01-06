require_relative './calculateable'
require_relative './gatherable'

module SeasonStats
  include Calculateable
  include Gatherable

  def biggest_bust(season_id)
    regular = team_regular_season_record(season_id)
    post = team_postseason_record(season_id)
    biggest_difference = win_percentage_difference(regular, post)
    require 'pry'; binding.pry
  end
end
