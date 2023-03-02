require_relative 'classes'

class LeagueStats < Classes
  def initialize(locations)
    super
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    average_goals_per_team = self.average_goals_per_team
    best_team_id = average_goals_per_team.sort_by { |_,v| v }.last[0]
    convert_id_to_teamname(best_team_id)
  end

  #Name of the team with the lowest average number of goals scored per game across all seasons.
  def worst_offense
    average_goals_per_team = self.average_goals_per_team
    best_team_id = average_goals_per_team.sort_by { |_,v| v }.first[0]
    convert_id_to_teamname(best_team_id)
  end

  #Helper method for best offense/ worst offense
  def convert_id_to_teamname(id_string)
    team = @teams.select{|team|team.team_id == id_string}
    team[0].teamname
  end

  #Helper method for best offense/ worst offense
  def average_goals_per_team
    goals_per_team = self.goals_per_team
    games_per_team = self.games_per_team
    average_goals_per_team = Hash.new(0)
    goals_per_team.each do |key, value|
      average_goals_per_team[key] = goals_per_team[key].to_f/games_per_team[key].to_f
    end
    average_goals_per_team
  end

  #Helper method for best offense/ worst offense
  def goals_per_team
    goals_per_team = Hash.new(0)
    @game_teams.each do |game|
      goals_per_team[game.team_id] += game.goals.to_i
    end
    goals_per_team
  end

  #Helper method for best offense/ worst offense
  def games_per_team
    games_per_team = Hash.new(0)
    @game_teams.each do |game|
      games_per_team[game.team_id] += 1
    end
    games_per_team
  end

  #Helper methods for finding average goals thru line 99
  def home_goals_per_team
    home_goals_per_team = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'home'
      home_goals_per_team[game.team_id] += game.goals.to_i
    end
  end
  home_goals_per_team
  end
  
  def away_goals_per_team
    away_goals_per_team = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'away'
        away_goals_per_team[game.team_id] += game.goals.to_i
      end
    end
  away_goals_per_team
  end

  def home_games_per_team
    home_games_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == "home"
        home_games_hash[game.team_id] += 1
      end
    end
    home_games_hash
  end

  def away_games_per_team
    away_games_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == "away"
        away_games_hash[game.team_id] += 1
      end
    end
    away_games_hash
  end
  ################################################
  
  def highest_scoring_home_team
    goals = home_goals_per_team
    games = home_games_per_team
    highest_avg = goals.merge(games){|team_id, games, goals| goals.fdiv(games)}
    highest_scoring = highest_avg.min_by {|k,v| v}
    id_string = highest_scoring[0]
    convert_id_to_teamname(id_string)
  end

  def highest_scoring_visitor
    goals = away_goals_per_team
    games = away_games_per_team
    highest_avg = goals.merge(games){|team_id, games, goals| goals.fdiv(games)}
    highest_scoring = highest_avg.min_by {|k,v| v}
    id_string = highest_scoring[0]
    convert_id_to_teamname(id_string)
  end

  def highest_scoring_away_team
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.max_by{|k,v| v}[0]
      end
    numer = scores.max_by{|k, v| v}
    denom = away_games_per_team.max_by{|k, v| v}
    highest_avg = (numer[1]).fdiv(denom[1])
    convert_id_to_teamname(numer[0])
  end

  def lowest_scoring_away
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.min_by{|k,v| v}[0]
      end
    numer = scores.min_by{|k, v| v}
    denom = away_games_per_team.min_by{|k, v| v}
    lowest_avg = numer[1].fdiv(denom[1])
    convert_id_to_teamname(numer[0])
  end

  def lowest_scoring_home
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.min_by{|k,v| v}[0]
      end
    numer = scores.min_by{|k, v| v}
    denom = home_games_per_team.min_by{|k, v| v}
    lowest_avg = numer[1].fdiv(denom[1])
    convert_id_to_teamname(numer[0])
  end

end