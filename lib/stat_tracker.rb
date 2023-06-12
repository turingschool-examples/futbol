require "csv"
require_relative 'team_factory'
require_relative 'game_teams_factory'
require_relative 'game_factory'

class StatTracker 

  def self.from_csv(locations)
    game_factory = create_games_factory(locations[:games])
    team_factory = create_teams_factory(locations[:teams])
    game_teams_factory = create_game_teams_factory(locations[:game_teams])
    StatTracker.new(game_factory, team_factory, game_teams_factory)
  end

  def self.create_teams_factory(path)
    team_factory = TeamFactory.new
    team_factory.create_teams(path)
    team_factory
  end
  
  def self.create_games_factory(path)
    game_factory = GameFactory.new
    game_factory.create_games(path)
    game_factory
  end

  def self.create_game_teams_factory(path)
    game_teams_factory = GameTeamsFactory.new
    game_teams_factory.create_game_teams(path)
    game_teams_factory
  end

  def initialize(game_factory, team_factory, game_teams_factory)
    @game_factory = game_factory
    @team_factory = team_factory
    @game_teams_factory = game_teams_factory
  end

  def percentage_home_wins
    home_wins = 0 
    @game_factory.games.each do |game|
      if game[:home_goals] > game[:away_goals]
        home_wins += 1
      end
    end
    percentage_wins = (home_wins.to_f / @game_factory.games.count.to_f)
    percentage_wins.round(2)
  end
  
  def percentage_ties
    ties = @game_factory.games.count do |game|
      game[:away_goals] == game[:home_goals]
    end
    (ties.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0 
    @game_factory.games.each do |game|
      if game[:away_goals] > game[:home_goals]
        visitor_wins += 1
      end
    end
    percentage_wins = (visitor_wins.to_f / @game_factory.games.count.to_f)
    percentage_wins.round(2)
  end

  def percentage_ties
    @game_factory.percentage_ties
  end

  def best_offense
    best_offense_team_id = goals_per_team.max_by { |team_id, goals| goals }[0]
    best_team = @team_factory.teams.find do |team|
      if best_offense_team_id == team[:team_id]
        team
      end
    end
    best_team[:team_name]  
  end

  def worst_offense
    worst_offense_team_id = goals_per_team.min_by { |team_id, goals| goals }[0]
    worst_team = @team_factory.teams.find do |team|
      if worst_offense_team_id == team[:team_id]
        team
      end
    end
    worst_team[:team_name] 
  end

  def goals_per_team
    team_goals = Hash.new(0)
    @game_teams_factory.game_teams.each do |game|
      team_goals[game[:team_id]] += game[:goals].to_i
    end
    team_goals
  end


  def highest_sum 
    hash = {}
    @game_factory.games.each do |game|
      if hash.key?(game[:home_team_id])
        hash[game[:home_team_id]] += game[:home_goals].to_i
      else
        hash[game[:home_team_id]] = game[:home_goals].to_i
      end

      if hash.key?(game[:away_team_id])
        hash[game[:away_team_id]] += game[:away_goals].to_i
      else
        hash[game[:away_team_id]] = game[:away_goals].to_i
      end
    end
  hash.values.max
  end

  def lowest_sum 
    hash = {}
    @game_factory.games.each do |game|
      if hash.key?(game[:home_team_id])
        hash[game[:home_team_id]] += game[:home_goals].to_i
      else
        hash[game[:home_team_id]] = game[:home_goals].to_i
     end

      if hash.key?(game[:away_team_id])
        hash[game[:away_team_id]] += game[:away_goals].to_i
      else
        hash[game[:away_team_id]] = game[:away_goals].to_i
      end

    end
  hash.values.min
  end
  
  def look_up_team_name(team_id)
    team = @team_factory.teams.find do |team|
      team_id == team[:team_id]
    end
    team[:team_name]
  end

  def lowest_scoring_visitor
    lsv = @game_factory.games.min_by do |game|
      game[:away_goals]
    end
    look_up_team_name(lsv[:away_team_id])  
  end

  def count_of_teams 
    @team_factory.teams.count
  end


  def winningest_coach(season_id)
    games_per_season = @game_factory.games.find_all do |game|
      game if game[:season] == season_id
    end

    game_teams_per_season = []
    games_per_season.each do |game|
      @game_teams_factory.game_teams.each do |game_team|
        game_teams_per_season.push(game_team) if game[:game_id] == game_team[:game_id]
      end
    end

    wins_per_coach = Hash.new(0)
    game_teams_per_season.each do |game_team|
      wins_per_coach[game_team[:head_coach]] += 1 if game_team[:result] == "WIN"
    end
    
    wins_per_coach.max_by { |coach, wins| wins }[0] 
  end
end
