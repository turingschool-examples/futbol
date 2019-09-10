module SeasonStatistics


  def biggest_bust(season)
    games_by_team = @game_teams.group_by do |game_team|
      game_team.team_id
    end
    games_by_team.each do |team_id, games|
      ps_game = games.find_all do |game|
        @games[game.game_id].type == "Postseason"
      end
    end
  end

  def most_tackles(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_teams = filtered_games.group_by(&:team_id)

    most_tackles_team_id = nil
    most_tackles = 0
    games_by_teams.each do |team_id, games_arr|
      tackles = games_arr.sum {|game| game.tackles}
      if tackles > most_tackles
        most_tackles_team_id = team_id
        most_tackles = tackles
      end
    end
    @teams[most_tackles_team_id].team_name
  end

  def fewest_tackles(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_teams = filtered_games.group_by(&:team_id)

    fewest_tackles_team_id = nil
    fewest_tackles = 100_000
    games_by_teams.each do |team_id, games_arr|
      tackles = games_arr.sum {|game| game.tackles}
      if tackles < fewest_tackles
        fewest_tackles_team_id = team_id
        fewest_tackles = tackles
      end
    end
    @teams[fewest_tackles_team_id].team_name
  end
end
