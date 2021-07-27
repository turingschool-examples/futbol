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
    games_by_team = []

    @game_teams.each do |game|
      games_by_team << game if game[:team_id] == team_id.to_s
      # require "pry"; binding.pry
    end
    # require "pry"; binding.pry 
    games_by_team
  end

end
