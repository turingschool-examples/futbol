class Game
  attr_reader :game_id,
    :season,
    :type,
    :date_time,
    :away_team_id,
    :home_team_id,
    :venue,
    :venue_link

  def initialize(game_info)
    game_info.each do |key, value|
      instance_variable_set("@#{key}".downcase, value) unless value.nil?
    end
  end

  def away_goals
    @away_goals.to_i
  end

  def home_goals
    @home_goals.to_i
  end

  def total_score
    away_goals + home_goals
  end

  def game_goal_difference
    (home_goals - away_goals).abs
  end

  def home_team_win?
    home_goals > away_goals
  end

  def visitor_team_win?
    home_goals < away_goals
  end

  def tie_game?
    home_goals == away_goals
  end
end
