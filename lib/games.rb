require './lib/stat_tracker'
require 'pry'

module Games

  #Highest sum of the winning and losing teams’ scores	Integer
  #BB
  def highest_total_score
    sum = 0
    self.games.each do |game|
      #game["home_goals"] returns the value of the "home_goals" key.
      if (game["home_goals"].to_i + game["away_goals"].to_i) > sum
        sum = (game["home_goals"].to_i + game["away_goals"].to_i)
      end
    end
    sum
  end

  #Lowest sum of the winning and losing teams’ scores	Integer
  #BB
  def lowest_total_score
    sum = 100
    self.games.each do |game|
      if (game["home_goals"].to_i + game["away_goals"].to_i) < sum
        sum = game["home_goals"].to_i + game["away_goals"].to_i
      end
    end
    sum
  end

  #Highest difference between winner and loser	Integer
  #BB
  def biggest_blowout
    biggest_blowout_value = 0
    self.games.each do |game|
      if game["home_goals"].to_i > game["away_goals"].to_i
        blowout_value = game["home_goals"].to_i - game["away_goals"].to_i
        if blowout_value > biggest_blowout_value
          biggest_blowout_value = blowout_value
        end
      elsif game["away_goals"].to_i > game["home_goals"].to_i
        blowout_value = game["away_goals"].to_i - game["home_goals"].to_i
        if blowout_value > biggest_blowout_value
          biggest_blowout_value = blowout_value
        end
      end
    end
    biggest_blowout_value
  end

  #Percentage of games that a home team has won (rounded to the nearest 100th)	Float
  #JP
  def percentage_home_wins
    home_wins = 0
    self.games.each do |game|
      if game["home_goals"].to_i > game["away_goals"].to_i
        home_wins += 1
      end
    end

    (home_wins.to_f / (self.games.length).to_f).round(2)
  end

  #Percentage of games that a visitor has won (rounded to the nearest 100th)	Float
  #JP
  def percentage_visitor_wins
    away_wins = 0
    self.games.each do |game|
      if game["home_goals"].to_i < game["away_goals"].to_i
        away_wins += 1
      end
    end

    (away_wins.to_f / (self.games.length).to_f).round(2)
  end

  #Percentage of games that has resulted in a tie (rounded to the nearest 100th)	Float
  #JP
  def percentage_ties
    ties = 0
    self.games.each do |game|
      if game["home_goals"].to_i == game["away_goals"].to_i
        ties += 1
      end
    end

    (ties.to_f / (self.games.length).to_f).round(2)
  end

  # #A hash with season names (e.g. 20122013) as keys and counts of games as values	Hash
  # #AM
  # def count_of_games_by_season
  #
  # end
  #
  # #Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)	Float
  # #AM
  # def average_goals_per_game
  #
  # end
  #
  # #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the #average number of goals in a game for that season as a key (rounded to the nearest 100th)	Hash
  # #AM
  # def average_goals_by_season
  #
  # end

end
