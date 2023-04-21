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
    # across all seasons when they are away.	
    # return value is String
    
    @games.map do |game|
      require 'pry'; binding.pry

    end
  end

  def highest_scoring_home_team
    # Name of the team with the highest average score per game 
    #across all seasons when they are home.	return value - String
  end
end
