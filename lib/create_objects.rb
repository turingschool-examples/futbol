
module CreateObjects
  def game_teams_collection(game_teams_path)
    GameTeamsCollection.new(game_teams_path)
  end

  def games_collection(games_path)
    GamesCollection.new(games_path)
  end

  def teams_collection(teams_path)
    TeamsCollection.new(teams_path)
  end
end
