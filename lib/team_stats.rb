require './lib/details_loader'


class Team < DetailsLoader

   def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end