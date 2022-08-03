require './lib/details_loader'
require './reusable'

class SeasonStats < DetailsLoader
  include Reusables

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
    @details = DetailsLoader.new(games, teams, game_teams)
  end

  def winningest_coach(season) #issue # 17 - FAIL wrong name returns
   # Name of the Coach with the best win percentage for the season
   highest_percent_wins = team_win_percent_by_season[season.to_i].max_by {|stat| stat[:win_perc]}
   coach_by_team_id[highest_percent_wins[:team_id]][season.to_i].sample

  end

  def worst_coach(season)#issue # 27 - FAIL 2/3 tests PASS - on fail it is providing diff team/name
    lowest_percent_wins = team_win_percent_by_season[season.to_i].min_by {|stat| stat[:win_perc]}
    coach_by_team_id[lowest_percent_wins[:team_id]][season.to_i].sample
  end


end