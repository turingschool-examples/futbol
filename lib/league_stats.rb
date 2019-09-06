module LeagueStats

# Total teams in data -integer
  def count_of_teams
    @team_objs.length

  end

# Team with highest average goals scored per game, all seasons -string
  def best_offense
    max = generate_average.max_by {|team,average| average }[0]
    @team_objs.find {|object| object.team_id == max}.teamName
  end

  def generate_num_goals_per_team
    goals_per_team = Hash.new(0)
    @game_teams_objs.each do |object|
        require 'pry' ; binding.pry
      goals_per_team[object.team_id] += object.goals
    end
    goals_per_team
  end

  def generate_num_games_per_team
    games_per_team = Hash.new(0)
    @game_teams_objs.each do |object|
      games_per_team[object.team_id] += 1
    end
    games_per_team
  end

  def generate_average
    averages = {}
    generate_num_goals_per_team.each do |team, goals|
      averages[team] = goals / generate_num_games_per_team[team]
    end
  end

# Team with lowest average goals scored per game, all seasons -string
  def worst_offense
    min = generate_average.min_by {|team,average| average }[0]
    @team_objs.find {|object| object.team_id == min}.teamName
  end


# Team with lowest number of goals allowed per game, all seasons -string
  def best_defense
    min = generate_average.min_by {|team, allowed| allowed }[0]
    @team_objs.find {|obj| obj.team_id == min }
  end

# Team with highest number of goals allowed per game, all seasons -string
  def worst_defense
    max = generate_average.max_by {|team, allowed| allowed }[0]
    @team_objs.find {|obj| obj.team_id == max }
  end

  def generate_allowed_goals
    allowed_goals = Hash.new(0)
    @game_objs.each do |obj|
      allowed_goals[obj.home_team_id] += obj.away_goals
    end
    allowed_goals
  end

  def generate_average
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
