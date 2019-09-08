module LeagueStats

  def count_of_teams
    @teams.length
  end

  def best_offense
    max = generate_average_goals[0].max_by {|team,average| average }
    @teams[max[0]].teamName
  end

  def worst_offense
    min = generate_average_goals[0].min_by {|team,average| average }
    @teams[min[0]].teamName
  end


  def best_defense
    min = generate_average_allowed.min_by {|team, allowed| allowed }[0]
    @teams[min].teamName
  end

  def worst_defense
    max = generate_average_allowed.max_by {|team, allowed| allowed }[0]
    @teams[max].teamName
  end

  def highest_scoring_visitor
    generate_average_goals
    max = generate_average_goals[2].max_by {|id, goals| goals}[0]
    @teams[max].teamName
  end

  def highest_scoring_home_team
    generate_average_goals
    max = generate_average_goals[1].max_by {|id, goals| goals}[0]
    @teams[max].teamName
  end

  def lowest_scoring_visitor
    generate_average_goals
    min = generate_average_goals[2].min_by {|id, goals| goals}[0]
    @teams[min].teamName
  end

  def lowest_scoring_home_team
    generate_average_goals
    min = generate_average_goals[1].min_by {|id, goals| goals}[0]
    @teams[min].teamName
  end


  def winningest_team
    highest = calculate_percents[2].max_by {|id, percent| percent}[0]
    @teams[highest].teamName
  end

  def best_fans
    calculate_percents
    home_away_difference = Hash.new(0)
    calculate_percents[1].each do |k, v|
      home_away_difference[k] = (v - calculate_percents[0][k]).abs
    end
    team = home_away_difference.max_by {|id, difference| difference}[0]
    @teams[team].teamName
  end

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

"----------------------SUPPORT METHODS-----------------------------------------"

  def generate_num_goals_per_team
    @goals_per_team = {}
    return @goals_per_team unless @goals_per_team.empty?
    @goals_per_team = Hash.new(0)
    @game_teams.each do |id, array|
      array.each do |game_obj|
        @goals_per_team[game_obj.team_id] += game_obj.goals
      end
    end
    @goals_per_team
  end
  
  def generate_num_games_per_team
    @game_counts = []
    return @game_counts unless @game_counts.empty?
    @games_per_team = Hash.new(0)
    @games_per_team_away = Hash.new(0)
    @games_per_team_home = Hash.new(0)
    @game_counts = [@games_per_team, @games_per_team_away, @games_per_team_home]
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

  def generate_average_goals
    @averages_total = []
    return @averages_total unless @averages_total.empty?
    generate_num_games_per_team
    generate_num_goals_per_team
    @averages = {}
    @averages_home = {}
    @averages_away = {}
    @averages_total = [@averages, @averages_home, @averages_away]
    generate_num_goals_per_team.each do |id, goals|
      @averages[id] = (goals.to_f / generate_num_games_per_team[0][id]).round(2)
    end
    generate_home_and_away_goals[0].each do |id, goals|
      @averages_away[id] = (goals.to_f / generate_num_games_per_team[1][id]).round(2)
    end
    generate_home_and_away_goals[1].each do |id, goals|
      @averages_home[id] = (goals.to_f / generate_num_games_per_team[2][id]).round(2)
    end
    @averages_total
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
    @home_and_away_goals = []
    return @home_and_away_goals unless @home_and_away_goals.empty?
    @home_and_away_goals = [Hash.new(0), Hash.new(0)]
    @games.each do |team_id, object|
      @home_and_away_goals[0][object.away_team_id] += object.away_goals
      @home_and_away_goals[1][object.home_team_id] += object.home_goals
    end
    @home_and_away_goals
  end


  def generate_wins
    @wins = []
    return @wins unless @wins.empty?
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
    @percents = []
    return @percents unless @percents.empty?
    @percent_by_away = {}
    @percent_by_home = {}
    @percent_by_team = {}
    @percents = [@percent_by_away, @percent_by_home, @percent_by_team]
    generate_wins[0].each do |k,v|
      @percent_by_away[k] = (v / generate_num_games_per_team[1][k].to_f * 100).round(2)
    end
    generate_wins[1].each do |k,v|
      @percent_by_home[k] = (v / generate_num_games_per_team[2][k].to_f * 100).round(2)
    end
    generate_wins[2].each do |k,v|
      @percent_by_team[k] = (v / generate_num_games_per_team[0][k].to_f * 100).round(2)
    end
    @percents
  end
end
