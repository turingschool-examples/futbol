class StatTracker
  def self.parse_csv path
    CSV.read(path, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    game_teams_data = parse_csv(locations[:game_teams])
    games_data = parse_csv(locations[:games])
    teams_data = parse_csv(locations[:teams])

    GameTeam.create_game_teams(game_teams_data)
    Game.create_games(games_data)
    Team.create_teams(teams_data)

    StatTracker.new()
  end
end
