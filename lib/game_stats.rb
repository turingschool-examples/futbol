module GameStats

  def highest_total_score #integer
    #Highest sum of the winning and losing teams’ scores
    game = @game_objs.max_by do |object|
      object.away_goals + object.home_goals
    end
    game.away_goals + game.home_goals

  end

  def lowest_total_score #integer
    game = @game_objs.min_by do |object|
      object.away_goals + object.home_goals
    end
    game.away_goals + game.home_goals
  end

  def biggest_blowout #integer
    game = @game_objs.max_by do |object|
      (object.away_goals - object.home_goals).abs
    end
    (game.away_goals - game.home_goals).abs 
  end

  def percentage_home_wins #float
    #Percentage of games that a home team has won (rounded to the nearest 100th)
    @game_objs.count do |object|
      object.home_goals > object.away_goals
    end/@game_objs.length.to_f * 100
  end

  def percentage_visitor_wins #float
    @game_objs.count do |object|
      object.away_goals > object.home_goals
    end/@game_objs.length.to_f * 100
  end

  def percentage_ties #float
    @game_objs.count do |object|
      object.home_goals == object.away_goals
    end/@game_objs.length.to_f * 100
  end

  def count_of_games_by_season #hash
    #A hash with season names (e.g. 20122013) as keys and counts of games as values
    games_by_season = Hash.new(0)
    @game_objs.each do |object|
      games_by_season[object.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game #float
    #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
    @game_objs.inject(0) {|sum, object| sum += (object.home_goals + object.away_goals)} / @game_objs.length.to_f.round(2)

  end

  def average_goals_by_season #hash
    #Average number of goals scored in a game organized in a hash with season
    # names (e.g. 20122013) as keys and a float representing the average number of
    #  goals in a game for that season as a key (rounded to the nearest 100th)
    # goals_by_season = {}
    goals_by_season = Hash.new(0)
    @game_objs.each do |object|
      goals_by_season[object.season] += (object.away_goals + object.home_goals)
    end
    goals_by_season.each do |season, goals|
      goals_by_season[season] = goals / count_of_games_by_season[season].to_f
    end
  end


end
