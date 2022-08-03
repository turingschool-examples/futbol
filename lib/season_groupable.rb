module SeasonGroupable
  def games_by_team_id_and_season(season)
    games_by_season = season_grouper[season] #season grouper is all games from the games csv grouped by season in arrays
    home_games = games_by_season.group_by { |game| game.home_team_id }
    away_games = games_by_season.group_by { |game| game.away_team_id }
    games_by_team_id =
      home_games.merge(away_games) { |team_id, home_game_array, away_game_array| home_game_array + away_game_array }
    #merged hash has 30 keys: each team's id. values are all games for a given season
  end

  def season_grouper #games helper, returns a hash with the season as the key and array of all games for the season as the value
    @games.group_by { |game| game.season }
  end

 def games_by_season(season_id)
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
        game_id_list << game.game_id
      end
    end
    game_id_list
  end

  def all_tackles_this_season(season)
    tackles_by_team = Hash.new(0)
    @game_stats.games_by_team_id_and_season(season).flat_map { |team_id, games|
      games.map { |game|
        tackles_by_team[team_id] +=
          @game_teams_stats.number_of_tackles(team_id, game.game_id)}}
    tackles_by_team
  end
end
