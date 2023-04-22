require_relative "futbol"

class LeagueStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
    @games.map(&:game_id).uniq.length
  end

  def best_offense
    best_offense = Hash.new(0)
    @games.each do |game|
      best_offense[game_team.team_id] = average_number_of_goals(game)
    end
    sorted = best_offense.max_by{|team, avg_goals| avg_goals}
    team_id_string = sorted[0]
    team_id_converter(team_id_string)
  
  
    total_goals = (total_goals_by_team(game_team.team_id))
    total_goals.fdiv(total_games_by_team(game_team.team_id))
  

    total_goals = 0
    @game_teams.each do |game_team|
      total_goals += game_team.goals if game_team.team_id == team_id
    end
    total_goals
  end

  def worst_offense

  end


  def highest_scoring_visitor

    games.map do |game|
          
      visitor_hash = Hash.new(0)
      if game.home_away == "away"
        count_of_games = 0
        count_of_goals = 0
      end
    end.max()
  end

  def highest_scoring_home_team
    games.map do |game|
      count_of_games = 0
      count_of_goals = 0
      if game.home_away == "home"
        count_of_games += 1
        count_of_goals += game.goals
      end
      count_of_goals / count_of_games
    end.max()
  end

  def lowest_scoring_visitor
    games.map do |game|
      count_of_games = 0
      count_of_goals = 0
      if game.home_away == "away"
        count_of_games += 1
        count_of_goals += game.goals
      end
      count_of_goals / count_of_games
    end.min()
  end

  def lowest_scoring_home_team
    games.map do |game|
      count_of_games = 0
      count_of_goals = 0
      if game.home_away == "home"
        count_of_games += 1
        count_of_goals += game.goals
      end
      count_of_goals / count_of_games
    end.min()
  end

  #Helper Methods
  def average_number_of_goals(game)
    total_goals = (total_goals_by_team(game_team.team_id))
    total_goals.fdiv(total_games_by_team(game_team.team_id))
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
    name_of_team
  end

  def avg_score_games(filtered_teams)
    filtered_teams.transform_values do |games|
      goals = games.sum{|game| game.goals}
      goals.fdiv(games.length)
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