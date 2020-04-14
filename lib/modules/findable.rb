module Findable

  def all_games_for(num)
    id = num.to_i
    @game_stats.find_all {|game_stat| game_stat.team_id == id}
  end

  def all_games(id)
    number_id = id.to_i
    @games_list.find_all{|game|(game.home_team_id == id) || (game.away_team_id == number_id)}
  end

  def all_games_by_season(id)
    all_games(id).group_by {|game| game.season}
  end
end
