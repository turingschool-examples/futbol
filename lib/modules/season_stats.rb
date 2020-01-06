require_relative './calculateable'
require_relative './gatherable'

module SeasonStats
  include Calculateable
  include Gatherable

  def biggest_bust(season_id)
    # in: season_id
    # out: team_id
    # team_win_percentage(wins_by_team(@seasons.teams[season_id]))
    #     team_win_percentage(postseason_games_by_team)
    #     team_win_percentage(regular_season_games_by_team)

    # @seasons.teams.reduce({}) do |hash, season|
    #   require 'pry'; binding.pry

    #   season(season_id)
    # end
    # get_team_name_by_id(team_id)
  end

  def winningest_coach(season_id)
    season_coach_win_percent(season_wins_by_coach(season_id), season_id).compact.max_by { |_id, avg| avg }[0]
  end

  def worst_coach(season_id)
    season_coach_win_percent(season_wins_by_coach(season_id), season_id).compact.min_by { |_id, avg| avg }[0]
  end
end
