class Game
  attr_reader :game_id,
              :away_goals,
              :home_goals,
              :season,
              :away_team_id,
              :home_team_id

  def initialize(raw_data)
    @game_id = raw_data[:game_id]
    @season = raw_data[:season]
    # @type = raw_data[:type]
    # @date_time = raw_data[:date_time]
    @away_team_id = raw_data[:away_team_id] ##
    @home_team_id = raw_data[:home_team_id] ##
    @away_goals = raw_data[:away_goals].to_i
    @home_goals = raw_data[:home_goals].to_i
    # @venue = raw_data[:venue]
    # @venue_link = raw_data[:venue_link]
  end

  def home_team?(team_id)
    team_id == home_team_id
  end

  def away_team?(team_id)
    team_id == away_team_id
  end

  def won?(team_id)
    home_team_won?(team_id) || away_team_won?(team_id)
  end

  def home_team_won?(team_id)
    home_team?(team_id) && home_goals > away_goals
  end

  def away_team_won?(team_id)
    away_team?(team_id) && away_goals > home_goals
  end

  def total_goals
    home_goals + away_goals
  end

end
