require_relative "futbol"

class LeagueStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
    @games.map(&:away_team_id).uniq.length
  end

  def best_offense
    best_offense = Hash.new(0)
    @games.each do |game|
      best_offense[game.away_team_id] = average_number_of_goals(game)
      best_offense[game.home_team_id] = average_number_of_goals(game)
    end
    sorted = best_offense.max_by{|team, avg_goals| avg_goals}
    team_string = sorted[0]
    team_id_into_name(team_string)
  end

  def worst_offense
    worst_offense = Hash.new(0)
    @games.each do |game|
      worst_offense[game.team_id] = average_number_of_goals(game)
    end
    sorted = worst_offense.min_by{|team, avg_goals| avg_goals}
    team_string = sorted[0]
    team_id_into_name(team_string)
  end


  def highest_scoring_visitor
    best_offense_visitor = Hash.new(0)
    filter_away_games.each do |game|
      best_offense_visitor[game.team_id] = average_number_of_goals(game)
    end
    sorted = best_offense_visitor.max_by{|team, avg_goals| avg_goals}
    team_string = sorted[0]
    team_id_into_name(team_string)
  end

  def highest_scoring_home_team
    best_offense_home = Hash.new(0)
    filter_away_games.each do |game|
      best_offense_home[game.team_id] = average_number_of_goals(game)
    end
    sorted = best_offense_home.max_by{|team, avg_goals| avg_goals}
    team_string = sorted[0]
    team_id_into_name(team_string)
  end

  def lowest_scoring_visitor
    worst_offense_visitor = Hash.new(0)
    filter_away_games.each do |game|
      best_offense_visitor[game.team_id] = average_number_of_goals(game)
    end
    sorted = worst_offense_visitor.min_by{|team, avg_goals| avg_goals}
    team_string = sorted[0]
    team_id_into_name(team_string)
  end

  def lowest_scoring_home_team
    worst_offense_home = Hash.new(0)
    filter_away_games.each do |game|
      worst_offense_home[game.team_id] = average_number_of_goals(game)
    end
    sorted = worst_offense_home.min_by{|team, avg_goals| avg_goals}
    team_string = sorted[0]
    team_id_into_name(team_string)
  end

  #Helper Methods
  def average_number_of_goals(game)
    total_goals = (total_goals_by_team(game.team_id))
    total_goals.fdiv(total_games_by_team(game.team_id))
  end

  def total_goals_by_team(team_id)
    total_goals = 0
    @games.each do |game|
      if game.team_id == team_id
      total_goals += game_team.goals
      end
    end
    total_goals
  end
  
  def total_games_by_team(team_id)
    total_games = 0
    @games.each do |game|
      if game.team_id == team_id
      total_games += 1 
      end
    end
    total_games
  end

  def team_id_into_name(team_id)
    name_of_team = " "
    @games.each do |game|
      if game.team_id == team_id
      name_of_team = game.team_name
      end
    end
    name_of_team
  end

  def avg_score_games(filtered_teams)
    filtered_teams.transform_values do |game|
      goals = game.goals.sum
      goals.fdiv(filtered_teams.length)
    end
  end

  def filter_by_team_id(team_id)
    @games.map do |game|
      if game.team_id == team_id
      end
    end 
  end

  def filter_away_games
    @games.map do |game|
      if game.home_away == "away"
      end
    end
  end

  def filter_home_games
    @games.map do |game|
      if game.home_away == "home"
      end
    end
  end
end