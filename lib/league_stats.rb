module LeagueStats

# Total teams in data -integer
  def count_of_teams
    @teams.length
  end

# Team with highest average goals scored per game, all seasons -string
  def best_offense
    max = generate_average[0].max_by {|team,average| average }
    @teams[max[0]].teamName
  end

# Team with lowest average goals scored per game, all seasons -string
  def worst_offense
    min = generate_average[0].min_by {|team,average| average }
    @teams[min[0]].teamName
  end

  def generate_num_goals_per_team
    return @goals_per_team unless @goals_per_team.nil?
    @goals_per_team = Hash.new(0)
    @game_teams.each do |id, array|
      @goals_per_team[array[0].team_id] += array[0].goals
    end
    @goals_per_team
  end

  # def generate_num_games_per_team
  #   return @games_per_team unless @games_per_team.nil?
  #   @games_per_team = Hash.new(0)
  #   @game_teams.each do |id, array|
  #     array.each do |game_object|
  #     @games_per_team[game_object.team_id] += 1
  #   end
  # end
  #
  #   @games_per_team
  # end

  def generate_num_games_per_team
    return @game_counts unless @games_counts.nil?
    @game_counts = [@games_per_team, @games_per_team_away, @games_per_team_home]
    @games_per_team = Hash.new(0)
    @games_per_team_away = Hash.new(0)
    @games_per_team_home = Hash.new(0)
    @game_teams.each do |id, array|
      array.each do |object|
        if object.hoa == "away"
          @games_per_team_away[object.team_id] += 1
        else
          @games_per_team_away[object.team_id] += 0
        end
        if object.hoa == "home"
          @games_per_team_home[object.team_id] += 1
        else
          @games_per_team_home[object.team_id] += 0
        end
        @games_per_team[object.team_id] += 1
      end
    end
    @game_counts
  end

  def generate_average
    return @averages_total unless @averages_total.nil?
    generate_num_games_per_team
    generate_num_goals_per_team
    @averages = {}
    @averages_home = {}
    @averages_away = {}
    @averages_total = [@averages, @averages_home, @averages_away]
    generate_num_goals_per_team.each do |team, goals|
      @averages[team] = goals.to_f / generate_num_games_per_team[0][team]
    end
    generate_home_and_away_goals[0].each do |team, goals|
      @averages_away[team] = goals.to_f / generate_num_games_per_team[1][team]
    end
    generate_home_and_away_goals[1].each do |team, goals|
      @averages_home[team] = goals.to_f / generate_num_games_per_team[2][team]
    end
    @averages_total
  end


# Team with lowest number of goals allowed per game, all seasons -string
  def best_defense
    min = generate_average_allowed.min_by {|team, allowed| allowed }[0]
      # require 'pry' ; binding.pry
    @teams[min].teamName
  end

# Team with highest number of goals allowed per game, all seasons -string
  def worst_defense
    max = generate_average_allowed.max_by {|team, allowed| allowed }[0]
    @teams[max].teamName
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
    generate_num_games_per_team
    averages = {}
    generate_allowed_goals.each do |team, allowed|
      averages[team] = allowed.to_f / generate_num_games_per_team[0][team]
    end
    averages
  end

  def generate_home_and_away_goals
    return @home_and_away_goals unless @home_and_away_goals.nil?
    @home_and_away_goals = [Hash.new(0), Hash.new(0)]
    @games.each do |team_id, object|
      @home_and_away_goals[0][object.away_team_id] += object.away_goals
      @home_and_away_goals[1][object.home_team_id] += object.home_goals
    end
    @home_and_away_goals
  end


# Name of away team with highest average score per game, all seasons -String
  def highest_scoring_visitor
    generate_average
    # generate_home_and_away_goals
    max = generate_average[2].max_by {|id, goals| goals}[0]
    @teams[max].teamName
  end

# Name of home team with highest average score per game, all seasons -string
  def highest_scoring_home_team
    generate_average
    # max = generate_home_and_away_goals[1].max_by {|id, goals| goals}[0]
    # @teams[max].teamName
    max = generate_average[1].max_by {|id, goals| goals}[0]
    @teams[max].teamName
  end

# Name of away team with lowest average score per game, all seasons -string
  def lowest_scoring_visitor
    generate_average
    min = generate_average[2].min_by {|id, goals| goals}[0]
    @teams[min].teamName
  end

# Name of home team with lowest average score per game, all seasons -string
  def lowest_scoring_home_team
    generate_average
    min = generate_average[1].min_by {|id, goals| goals}[0]
    @teams[min].teamName
  end

  def generate_wins
    return @wins unless @wins.nil?
    @wins_by_team = Hash.new(0)
    @wins_by_home = Hash.new(0)
    @wins_by_away = Hash.new(0)
    @wins = [@wins_by_away, @wins_by_home, @wins_by_team]

    @game_teams.each do |id, array|
      array.each do |object|
        if object.result == "WIN"
          @wins_by_team[id] += 1
        else
          @wins_by_team[id] += 0
        end
        if object.result == "WIN" && object.hoa == "away"
          @wins_by_away[id] += 1
        else
          @wins_by_away[id] += 0
        end
        if object.result == "WIN" && object.hoa == "home"
          @wins_by_home[id] += 1
        else
          @wins_by_home[id] += 0
        end
      end
    end
    @wins
  end

  def calculate_percents
      generate_num_games_per_team
      return @percents unless @percents.nil?
      @percent_by_away = {}
      @percent_by_home = {}
      @percent_by_team = {}
      @percents = [@percent_by_away, @percent_by_home, @percent_by_team]
      generate_wins[0].each do |k,v|
        @percent_by_away[k] = v / generate_num_games_per_team[1][k].to_f
      end
      generate_wins[1].each do |k,v|
        @percent_by_home[k] = v / generate_num_games_per_team[2][k].to_f
      end
      generate_wins[2].each do |k,v|
        @percent_by_team[k] = v / generate_num_games_per_team[0][k].to_f
      end
      @percents
  end

# Name of team with highest win percentage, all seasons -string
  def winningest_team
    highest = calculate_percents[2].max_by {|id, percent| percent}[0]
    @teams[highest].teamName
  end

# Name of team with biggest difference between home and away win percentages -string
  def best_fans
    calculate_percents
    home_away_difference = Hash.new(0)
    calculate_percents[1].each do |k, v|
      home_away_difference[k] = (v - calculate_percents[0][k]).abs
    end
    team = home_away_difference.max_by {|id, difference| difference}[0]
    @teams[team].teamName
  end

# List of names of all teams with better away records(wins) than home records(wins) -array
  def worst_fans
    generate_wins
    worst_fans = []
    records = Hash.new(0)
    @teams.each do |id, team_obj|
      records[id] = generate_wins[0][id] > generate_wins[1][id]
    end
    records.each do |id, boolean|
      if boolean == true
        worst_fans << @teams[id].teamName
      end
    end
    worst_fans
  end

end
