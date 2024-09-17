require 'CSV'

class StatTracker
  def average_goals_per_game
    # TODO: required
    # Average number of goals scored in a game across all
    # seasons including both home and away goals (rounded to the nearest 100th)
    # returns float
  end

  def average_goals_season
    # TODO: required
    # Average number of goals scored in a game organized
    # in a hash with season names (e.g. 20122013) as keys
    # and a float representing the average number of goals
    # in a game for that season as values (rounded to the nearest 100th)
    # returns hash
  end

  def get_average(scores)
    # TODO: helper method
    # returns float
  end

  def get_sum(scores)
    # TODO: helper method
    # returns int
  end

  def get_scores(team_id, season)
    # TODO: helper method
    # returns array of scores
    # season parameter option, set to all seasons by default
  end
end

