module Modable

  def fav_opp(id)
    freq = @teams1.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    numbs = @teams1.min_by { |v| freq[v] }
    @teams_array.select{ |team| team.team_id == numbs}[0].team_name
  end

  def goals(id)
    @away = @all_games.map{ |rows| rows.away_goals}
    @home = @all_games.map{ |rows| rows.home_goals}
  end
end
