module Gameable

  #Highest sum of the winning and losing teams’ scores	Integer
  #BB
  def highest_total_score
    sum = 0
    self.games.each_value do |object|
      #object.home_goals returns the value of the Games @home_goals.
      if (object.home_goals + object.away_goals) > sum
        sum = (object.home_goals + object.away_goals)
      end
    end
    sum
  end

  #Lowest sum of the winning and losing teams’ scores	Integer
  #BB
  def lowest_total_score
    sum = 100
    self.games.each_value do |object|
      if (object.home_goals + object.away_goals) < sum
        sum = object.home_goals + object.away_goals
      end
    end
    sum
  end

  #Highest difference between winner and loser	Integer
  #BB
  def biggest_blowout
    biggest_blowout_value = 0
    self.games.each_value do |object|
      if (object.home_goals - object.away_goals).abs > biggest_blowout_value
        biggest_blowout_value = (object.home_goals - object.away_goals).abs
      end
    end
    biggest_blowout_value
  end

  #Percentage of games that a home team has won (rounded to the nearest 100th)	Float
  #JP
  def percentage_home_wins
    home_wins = 0
    self.games.each_value do |object|
      if object.home_goals > object.away_goals
        home_wins += 1
      end
    end

    (home_wins / (self.games.length).to_f).round(2)
  end

  #Percentage of games that a visitor has won (rounded to the nearest 100th)	Float
  #JP
  def percentage_visitor_wins
    away_wins = 0
    self.games.each_value do |object|
      if object.home_goals < object.away_goals
        away_wins += 1
      end
    end

    (away_wins / (self.games.length).to_f).round(2)
  end

  #Percentage of games that has resulted in a tie (rounded to the nearest 100th)	Float
  #JP
  def percentage_ties
    ties = 0
    self.games.each_value do |object|
      if object.home_goals == object.away_goals
        ties += 1
      end
    end

    (ties / (self.games.length).to_f).round(2)
  end

  #A hash with season names (e.g. 20122013) as keys and counts of games as values	Hash
  #AM (completed)
  def count_of_games_by_season
    output = Hash.new(0)

    self.games.each_value do |game|
      output[game.season] += 1
    end

    output
  end

  #Average number of goals scored in a game across all seasons including both home and away goals
  #(rounded to the nearest 100th)	Float
  #AM (completed)
  def average_goals_per_game
    sum = 0.00
    self.games.each_value do |game|
      sum += (game.home_goals + game.away_goals)
    end

    (sum / self.games.length).round(2)
  end

  #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys
  #and a float representing the #average number of goals in a game for that season as a key
  #(rounded to the nearest 100th)	Hash
  #AM (completed)
  def average_goals_by_season
    seasons_goals = Hash.new(0.00)

    unique_seasons_array_helper.each do |season|
      self.games.each_value do |game|
        seasons_goals[season] += (game.home_goals + game.away_goals) if game.season == season
      end
    end

    seasons_goals.merge!(count_of_games_by_season)  do |key, oldval, newval|
      (oldval / newval).round(2)
    end

  end

  def unique_seasons_array_helper
    unique_seasons = []

    self.games.each_value do |game|
      unique_seasons << game.season
    end

    unique_seasons.uniq
  end

end
