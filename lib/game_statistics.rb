class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season]
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
    @venue = data[:venue]
    @venue_link = data[:venue_link]
  end

  def highest_total_score
    # Description: Highest sum of the winning and losing teams’ scores
    # Return Value: Integer
  end

  def lowest_total_score
    # Description: Lowest sum of the winning and losing teams’ scores
    # Return Value: Integer
  end

  def percentage_home_wins
    # Description: Percentage of games that a home team has won (rounded to the nearest 100th)
    # Return Value: Float
  end

  def percentage_visitor_wins
    # Description: Percentage of games that a visitor has won (rounded to the nearest 100th)
    # Return Value: Float
  end

  def percentage_ties
    # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
    # Return Value: Float
  end

  def count_of_games_by_season
    # A hash with season names (e.g. 20122013) as keys and counts of games as values.
    # Return Value: Hash
  end

  def average_goals_per_game
    # Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
    # Return Value: Float
  end

  def average_goals_by_season
    # Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
    # Return Value: Hash
  end
end
