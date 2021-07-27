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

  def best_offense
    @teams.each do |team|
      #some_method(team[:team_id])
    end.max[team_name]
  end

  #this will hit @game_teams again. Will need refactor to minimize time, nest games_by_team and add denominator count?.
  def games_average(team_id)
    sum = 0.00
    games_by_team(team_id).each do |game|
      sum += game[:goals].to_i
    end
    sum / games_by_team(team_id).length
  end

end
