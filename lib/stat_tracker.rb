require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative 'csv_loadable'

class StatTracker
  #CSVloadable doesn't need to be a module because we're only using it in one place

  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(locations)
    game_teams_path = locations[:game_teams]
    games_path      = locations[:games]
    teams_path      = locations[:teams]
    StatTracker.new(game_teams_path, games_path, teams_path)
  end

  def initialize(game_teams_path, game_path, teams_path, csv_loadable = CsvLoadable.new)
    @games      = csv_loadable.load_csv_data(game_path, Game)
    #can be stubbed because this is a method we didn't define in this class, it's included via module
    @teams      = csv_loadable.load_csv_data(teams_path, Team)
    @game_teams = csv_loadable.load_csv_data(game_teams_path, GameTeam)
  end

  #Game Statistics

  def highest_total_score
    scores = @games.max_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def lowest_total_score
    scores = @games.min_by do |game|
      game.total_goals
    end
    scores.total_goals
  end

  def percentage_home_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "home"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_visitor_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "away"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_ties #game_team manager
    games = @game_teams
    ties = @game_teams.find_all do |game|
      game if game.result == "TIE"
    end
    percentage(ties, games)
  end

  def percentage(array1, array2)
    percent = array1.length.to_f / array2.length.to_f
    readable_percent = (percent * 100).round(2)
  end

  def count_of_goals_by_season
    #	A hash with season names (e.g. 20122013) as keys and counts of games as values
    hash = Hash.new(0)

     @games.each do |game|
         hash[game.season.to_s] += game.away_goals + game.home_goals
        # require 'pry'; binding.pry
      end
     hash
   end

  def average_goals_per_game
    #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
    total_goals = @games.sum do |game|
                    game.away_goals + game.home_goals
                  end
    (total_goals/(@games.count.to_f)).round(2)
    # require 'pry'; binding.pry
  end

  def average_goals_by_season
    #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
    
   #sort out each season
   #calculate how many goals in each season
   #calculate how many games are in each season
   #divide number of goals by number of games
   #make that number the value in the hash
    game_season_totals = count_of_games_by_season
    goal_totals = count_of_goals_by_season
    hash = Hash.new(0)
  
    @games.each do |game|
      # require 'pry'; binding.pry
      hash[game.season.to_s] = (goal_totals[game.season.to_s].to_f/game_season_totals[game.season.to_s].to_f).round(2)
    end
    hash
  end
  # def quick_count
  #   @games.count
  # end

  #League Statistics

    def count_of_teams
      counter = 0
      @teams.each do |team|
        counter += 1
      end
      counter
    end

    def best_offense
    #Name of the team with the highest average number of goals scored per game across all seasons.
      scores = Hash.new

      @game_teams.each do |game_team|
        if scores[game_team.team_id] == nil
          scores[game_team.team_id] = []
          scores[game_team.team_id] << game_team.goals
        else
          scores[game_team.team_id] << game_team.goals
        end
      end
      data = Hash
      # require 'pry'; binding.pry


    #use teams, iterate over each team
    #use games, iterate over each game
    #count number of games each team plays
    #collect the sum of goals based on team ID
    #divide sum of goals by count of games
    #return the average as result[teamID] = average
    #look at values in result, pick the biggest one.
    #convert team ID to name as string
    end


  #Season Statistics



  #Team Statistics


end
