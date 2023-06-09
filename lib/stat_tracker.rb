require "csv"
require_relative 'team_factory'
require_relative 'game_teams_factory'
require_relative 'game_factory'

class StatTracker 

  def from_csv(path)
    if path == './data/games.csv'
     @game_factory = create_games_factory(path)
    elsif path == './data/teams.csv'
      @team_factory = create_teams_factory(path)
    else
      @game_teams_factory = create_game_teams_factory(path)
    end
  end

  def create_teams_factory(path)
    team_factory = TeamFactory.new
    team_factory.create_teams(path)
    team_factory
  end
  
  def create_games_factory(path)
   game_factory = GameFactory.new
   game_factory.create_games(path)
   game_factory
  end

  def create_game_teams_factory(path)
    game_teams_factory = GameTeamsFactory.new
    game_teams_factory.create_game_teams(path)
    game_teams_factory
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
  
  def percent_of_ties
    ties = @game_factory.games.count do |game|
      game[:away_goals] == game[:home_goals]
    end
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

  def best_offense
    team_goals = Hash.new(0)
    @game_teams_factory.game_teams.each do |game|
      team_goals[game[:team_id]] += game[:goals].to_i
    end
    best_offense_team_id = team_goals.max_by { |team_id, goals| goals }[0]
    best_team = @team_factory.teams.find do |team|
      if best_offense_team_id == team[:team_id]
        team
      end
    end
    best_team[:team_name]  
  end





  
end
