class League
    attr_reader :games, :teams, :game_teams

    def initialize(games, teams, game_teams)
      @games = games
      @teams = teams
      @game_teams = game_teams
  end

  def count_of_teams
    @teams.count
  end

  def best_offense #change argument as needed
    # team_id = averaging_hash.key(averaging_hash.values.max)
    # team_name_from_id(team_id)
  end
end
