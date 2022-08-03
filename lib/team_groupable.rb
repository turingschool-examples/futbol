module TeamGroupable

  def all_team_games(team_id) #games helper, returns all of a team's games in an array
    @games.find_all { |game| game.home_team_id == team_id || game.away_team_id == team_id }
  end

  def team_season_grouper(team_id) #helper, groups all of a team's games by season in a hash: the key is the season and the values are the team's games for that season
    all_games = all_team_games(team_id)
    all_games.group_by { |game| game.season }
  end
end
