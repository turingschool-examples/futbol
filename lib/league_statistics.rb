require_relative "./stat_tracker"
require_relative "./stat_helper"

class LeagueStatistics < StatHelper

  def initialize(files)
    super
  end

  # def count_of_teams
  #   @teams.length
  # end

  # def offense_avg
    
  # end

# Pseudocode: access the game_teams.csv file
# Pull the team_id and goals variables for each game
# Add the total number of goals for each team
# Divide the total goals by number of games for each team

  # def best_offense
    # offense_avg
    
  # end

# Pseudocode: access the game_teams.csv file
# Pull the team_id and goals variables for each game
# Add the total number of goals for each team
# Divide the total goals by number of games for each team
# ^^ in the offense_avg helper method
# Identify the team_id of the team with the highest average
# Match the team_id to the teamName (in the teams.csv file)
# Return teamName (in a string)


  # def worst_offense
    # offense_avg

  # end

# Pseudocode: access the game_teams.csv file
# Pull the team_id and goals variables for each game
# Add the total number of goals for each team
# Divide the total goals by number of games for each team
# ^^ in the offense_avg helper method
# Identify the team_id of the team with the lowest average
# Match the team_id to the teamName (in the teams.csv file)
# Return teamName (in a string)

  def highest_scoring_visitor
    # Name of the team with the highest average score per game 
    # across all seasons when they are away.	returns string

    visitor= {}

    away_teams = @game_teams.find_all do |game_team| 
      game_team.hoa == "away"
      game_team
    end
    away_teams
    
    @teams.each do |team|
      goals_per_team = 0
      games_per_team = 0
      
      away_teams.select do |game_team|
        if game_team.team_id == team.team_id
          goals_per_team += game_team.goals.to_f
          games_per_team += 1
          avg = (goals_per_team / games_per_team.to_f)
          visitor[team.team_id] = avg
        end
      end
    end
    
    visitor 
    
    highest_scoring_visitor = visitor.max_by {|id, avg| avg}
    require 'pry'; binding.pry
    
    @teams.find {|team| team.team_id == highest_scoring_visitor.first}.team_name


    # away_teams.each do |
        #search all the goals 
        #find the averages score
        # for the highest average score, take the team_id
        # go into the teams.csv and print the team_name associated

  end

end
