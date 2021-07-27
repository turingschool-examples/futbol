class League
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def count_of_teams
    @teams.length
  end

  def games_by_team(team_id)
    @game_teams.find_all do |game|
      game[:team_id] == team_id.to_s
    end
  end

end
