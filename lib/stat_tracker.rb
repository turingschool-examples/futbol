require './lib/game'
require './lib/team'
require './lib/game_team'
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
    scores = @games.flat_map do |game|
      game.total_score
      # [game.away_goals.to_i + game.home_goals.to_i]
      #needs to be refactored. 
      #anything that does any calculation should be refactored into a method that lives on it's assigned class
      #between the do and end block should be "game.total_score"
      #total score should be "away_goals.to_i + home_goals.to_i"
    end
    scores.max
  end
  
  def lowest_total_score #game_manager
    scores = @games.flat_map do |game|
      [game.away_goals.to_i + game.home_goals.to_i]
    end
    scores.min
  end

  def percentage_home_wins #game_team manager
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "home"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    percentage(wins, games)
  end

  def percentage_visitor_wins #game_team manager
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

  def percentage(array1, array2) #potential for a module later?
    percent = array1.length.to_f / array2.length.to_f
    readable_percent = (percent * 100).round(2)
  end

  def count_of_games_by_season
    #	A hash with season names (e.g. 20122013) as keys and counts of games as values
    hash = Hash.new(0)

     @games.each do |game|
      hash[game.season] += 1
     end
     hash
      # require 'pry'; binding.pry
  end

  def average_goals_per_game
    #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
    total_goals = @games.sum do |game|
                    game.away_goals + game.home_goals
                  end
    (total_goals/(@games.count.to_f)).round(2)
    require 'pry'; binding.pry
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



  #Season Statistics



  #Team Statistics


end
