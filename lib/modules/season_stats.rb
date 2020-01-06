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
    total_games = total_season_games_team_id(season_id)
    require 'pry'; binding.pry
    record = total_season_wins_losses_team_id(season_id)
  end
end
