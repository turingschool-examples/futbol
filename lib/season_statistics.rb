module SeasonStatistics


  def biggest_bust(season)
    games_by_team = @game_teams.group_by do |game_team|
      game_team.team_id
    end
    games_by_team.each do |team_id, games|
      ps_game = games.find_all do |game|
        @games[game.game_id].type == "Postseason"
      end
    require'pry';binding.pry
    end
  end
end

    # post_season_games = games_by_season[season].find_all do |game|
    #   game.season == "Postseason"
    # end
    # regular_season_games = games_by_season[season].find_all do |game|
    #   game.season == "Regular Season"
    # end
