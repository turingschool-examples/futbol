require 'csv'
require 'pry'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    StatTracker.new(
    CSV.read(locations[:games], headers: true, header_converters: :symbol),
    CSV.read(locations[:teams], headers: true, header_converters: :symbol),
    CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  )
  end

  def count_of_teams
    @teams.count
  end

  def id_team_hash # desired return {id: {name: "teamname", home_goals: num, away_goals: num}}
    @id_and_team = {}

    @teams.each do |team|
      @id_and_team[team[:team_id]] = team[:teamname]
    end
    @id_and_team
  end

  def number_of_games_played
    id_team_hash
    @number_played = @id_and_team

   @number_played.each do |id, team_name|
      games_played = Hash.new{0}

      @games.each do |game|
        if game[:home_team_id] == id #|| game[:away_team_id] == id
          games_played[:name] = team_name
          games_played[:home_games] += 1
        end
        if game[:away_team_id] == id #|| game[:away_team_id] == id
          games_played[:name] = team_name
          games_played[:away_games] += 1
        end
      end
      @number_played[id] = games_played
    end
  end

  def total_games
    number_of_games_played
    @number_played
    @total_games_by_team = {}

    @number_played.each do |id, team_game|
      @total_games_by_team[id] = (team_game[:home_games] + team_game[:away_games])
    end
  end

  def goals_by_id
    id_team_hash #method id_team_hash called to have access to @id_and_team
    @goals_scored = @id_and_team

    @goals_scored.each do |id, team_name|
      goals = Hash.new{0}

      @games.each do |game|
        if game[:home_team_id] == id
          goals[:name] = team_name
          goals[:home_goals] += game[:home_goals].to_i
        end
        if game[:away_team_id] == id
          goals[:name] = team_name
          goals[:away_goals] += game[:away_goals].to_i
        end
      end
      @goals_scored[id] = goals
    end
    @goals_scored
  end

  def total_goals
    goals_by_id
    @goals_scored
   @total_goals_by_team = {}

    @goals_scored.each do |id, team_goals|
      @total_goals_by_team[id] = (team_goals[:home_goals] + team_goals[:away_goals])
    end
  end

  def best_offense#does not account for ties in offenses with same number of points
  #highest average number of goals scored per game across all seasons.
  # goals/games
    id_team_hash; @id_and_team
    total_goals; @total_goals_by_team.sort
    total_games; @total_games_by_team.sort

     @total_goals_by_team.each do |id, goals|
        the_best = {}
        @total_games_by_team.each do |id, games|
          the_best[id] = (goals/games)
          binding.pry
        end
    end
    the_best
    # Name of the team 
  end

  def worst_offense
    id_team_hash
    goals_by_id
    @id_and_team
    the_worst = @id_and_team.sort_by do |id, team_info|
      team_info[:home_goals]
    end
    the_worst[0][1].values[0]
  end

  def highest_scoring_visitor
    id_team_hash
    goals_by_id
    @id_and_team
    the_best = @id_and_team.sort_by do |id, team_info|
      team_info[:away_goals]
    end
    the_best[-1][1].values[0]
  end
  
  def highest_scoring_home_team
    id_team_hash
    goals_by_id
    @id_and_team
    the_best = @id_and_team.sort_by do |id, team_info|
      team_info[:home_goals]
    end
    the_best[-1][1].values[0]
  end

  def lowest_scoring_visitor
    id_team_hash
    goals_by_id
    @id_and_team
    the_lowest = @id_and_team.sort_by do |id, team_info|
      team_info[:away_goals]
    end
    the_lowest[0][1].values[0]
  end

  def lowest_scoring_home_team
    id_team_hash
    goals_by_id
    @id_and_team
    the_lowest = @id_and_team.sort_by do |id, team_info|
      team_info[:home_goals]
    end
    the_lowest[0][1].values[0]
  end
end
