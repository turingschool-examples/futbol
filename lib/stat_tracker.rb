require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    scores = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores.max
  end


  def lowest_total_score
    scores = @games.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    scores.min
  end

  def percentage_home_wins
    (total_home_wins.to_f / total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    (total_away_wins.to_f / total_games.to_f).round(2)
  end

  def percentage_ties
    (total_ties.to_f / total_games.to_f).round(2)
  end

  def total_games
    @games.count
  end

  def total_home_wins
    home_wins = 0
    @games.each do |row|
      if row[:home_goals] >= row[:away_goals]
        home_wins += 1
      end
    end
    home_wins
  end

  def total_home_losses
    home_losses = 0
    @games.each do |row|
      if row[:away_goals] >= row[:home_goals]
        home_losses += 1
      end
    end
    home_losses
  end

  def total_ties
    total_ties = 0
    @games.each do |row|
      if row[:away_goals] == row[:home_goals]
        total_ties += 1
      end
    end
    total_ties
  end

  def total_away_losses
    total_home_wins
  end

  def total_away_wins
    total_home_losses
  end

  def count_of_games_by_season
    season = @games.map {|row| row[:season]}
    season.tally
  end

  def average_goals_per_game
    goals = @games.map {|row| row[:away_goals].to_f + row[:home_goals].to_f}
    goals = goals.sum
    (goals / total_games).round(2)
  end

  def average_goals_by_season
    hash = Hash.new(0)
    @games.map do |row|
      goals = row[:away_goals].to_f + row[:home_goals].to_f
      season = row[:season]
      hash[season] += goals
    end

    nested_arr = count_of_games_by_season.values.zip(hash.values)
    arr = nested_arr.map {|array| (array[1] / array[0]).round(2)}
    avg = Hash[count_of_games_by_season.keys.zip(arr)]
  end

  def count_of_teams
    @teams.count
  end

  def average_goals
    team_goals = Hash.new(0)
    @game_teams.map do |row|
      team_id = row[:team_id]
      goals = row[:goals].to_f
      team_goals[team_id] += goals
    end
    team_game = @game_teams.map {|row| row[:team_id]}.tally
    nested_arr = team_game.values.zip(team_goals.values)
    arr = nested_arr.map {|array| array[1] / array[0]}
    avg = Hash[team_game.keys.zip(arr)]
  end

  def best_offense
    best = average_goals.max_by {|key,value| value}
    hash = Hash.new
    @teams.map do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      hash[team_id] = team_name
    end
    num1 = hash.filter_map {|key,value| value if key == best[0] }
    num1[0]
  end

end
