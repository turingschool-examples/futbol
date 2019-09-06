module LeagueStats

# Total teams in data -integer
  def count_of_teams
    @teams.length
  end

# Team with highest average goals scored per game, all seasons -string
  def best_offense
    max = generate_average.max_by {|team,average| average }[0]
    @teams.find {|id, object| object.team_id == max}[1].teamName
  end

  def generate_num_goals_per_team
    goals_per_team = Hash.new(0)
    @game_teams.each do |id, object|
      goals_per_team[object.team_id] += object.goals
    end
    goals_per_team
  end

  def generate_num_games_per_team
    games_per_team = Hash.new(0)
    @game_teams.each do |id, object|
      games_per_team[object.team_id] += 1
    end
    games_per_team
  end

  def generate_average
    averages = {}
    generate_num_goals_per_team.each do |team, goals|
      #  require 'pry' ; binding.pry
      averages[team] = goals / generate_num_games_per_team[team]
    end
  end

# Team with lowest average goals scored per game, all seasons -string
  def worst_offense
    min = generate_average.min_by {|team,average| average }[0]

    @teams.find {|id, object| object.team_id == min}[1].teamName
  end


# Team with lowest number of goals allowed per game, all seasons -string
  def best_defense
    min = generate_average_allowed.min_by {|team, allowed| allowed }
      #require 'pry' ; binding.pry
    @teams.find {|id, obj| obj.team_id == min[0]}[1].teamName
  end

# Team with highest number of goals allowed per game, all seasons -string
  def worst_defense
    max = generate_average_allowed.max_by {|team, allowed| allowed }[0]
    #require 'pry' ; binding.pry
    @teams.find {|id, obj| obj.team_id == max }[1].teamName
  end

  def generate_allowed_goals
    allowed_goals = Hash.new(0)
    @games.each do |id, obj|
      allowed_goals[obj.home_team_id] += obj.away_goals
      allowed_goals[obj.away_team_id] += obj.home_goals
    end
    allowed_goals
  end

  def generate_average_allowed
    averages = {}
    generate_allowed_goals.each do |team, allowed|
      averages[team] = allowed / generate_num_games_per_team[team]
    end
    averages
  end


# Name of away team with highest average score per game, all seasons -String
  def highest_scoring_visitor

  end

# Name of home team with highest average score per game, all seasons -string
  def highest_scoring_home_team

  end

# Name of away team with lowest average score per game, all seasons -string
  def lowest_scoring_visitor

  end

# Name of home team with lowest average score per game, all seasons -string
  def lowest_scoring_home_team

  end

# Name of team with highest win percentage, all seasons -string
  def winningest_team

  end

# Name of team with biggest difference between home and away win percentages -string
  def best_fans

  end

# List of names of all teams with better away records(wins) than home records(wins) -array
  def worst_fans

  end

end
