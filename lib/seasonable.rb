module Seasonable

  def all_games_by_season
    @all_games_by_season ||= @games.group_by { |game| game.season } 
  end

  def sums_of_home_away_goals
    @sums_of_home_away_goals ||= @games.map { |game| (game.away_goals + game.home_goals)}
  end
  #=> returns array of all home/away goals per game (count7000-ish)

  def team_name(id)
    @teams.each do |team|
        return team.team_name if team.team_id == id 
    end
  end

end