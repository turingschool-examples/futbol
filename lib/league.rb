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

  def worst_offense
    acc = {}
    @teams.each do |team|
        #conditional handles edge cases where there are no games for the teams. Should not be a problem when dealing with the full dataset.
      if games_by_team(team.team_id).length != 0
        acc[games_average(team.team_id)] = team.team_name
      end
    end
    acc[acc.keys.min]
  end

  def best_offense
    acc = {}
    @teams.each do |team|
      #conditional handles edge cases where there are no games for the teams. Should not be a problem when dealing with the full dataset.
      if games_by_team(team.team_id).length != 0
        acc[games_average(team.team_id)] = team.team_name
      end
    end
    acc[acc.keys.max]
  end
  #this will hit @game_teams again. Will need refactor to minimize time, nest games_by_team and add denominator count?.
  def games_average(team_id)
    goals_scored = 0.00
    games_by_team(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored / games_by_team(team_id).length
  end

  def games_by_team(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id.to_s
    end
  end

  def away_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'away'
    end
  end

  def away_average(team_id)
    goals_scored = 0.00
    away_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(away_games(team_id).length)
  end

  def highest_scoring_visitor
    highest_scoring = {}
    @teams.each do |team|
      if away_games(team.team_id).length != 0
        highest_scoring[team.team_name] = away_average(team.team_id)
      end
    end
    highest_scoring.key(highest_scoring.values.max)
  end

  def lowest_scoring_visitor
    lowest_scoring = {}
    @teams.each do |team|
      if away_games(team.team_id).length != 0
        lowest_scoring[team.team_name] = away_average(team.team_id)
      end
    end
    lowest_scoring.key(lowest_scoring.values.min)
  end


  def home_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'home'
    end
  end

  #write test
  def home_average(team_id)
    goals_scored = 0.00
    home_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(home_games(team_id).length)
  end

  def highest_scoring_home_team
    highest_scoring = {}
    @teams.each do |team|
      if home_games(team.team_id).length != 0
        highest_scoring[team.team_name] = home_average(team.team_id)
      end
    end
    highest_scoring.key(highest_scoring.values.max)
  end

  def lowest_scoring_home_team
    lowest_scoring = {}
    @teams.each do |team|
      if home_games(team.team_id).length != 0
        lowest_scoring[team.team_name] = home_average(team.team_id)
      end
    end
    lowest_scoring.key(lowest_scoring.values.min)
  end

end
