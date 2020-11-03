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

  def initialize(row)
    @game_id = row[:game_id]
    @season = row[:season]
    @type = row[:type]
    @date_time = row[:date_time]
    @away_team_id = row[:away_team_id]
    @home_team_id = row[:home_team_id]
    @away_goals = row[:away_goals].to_i
    @home_goals = row[:home_goals].to_i
    @venue = row[:venue]
    @venue_link = row[:venue_link]
  end

  def total_score
    away_goals + home_goals
  end

  def won_game?(team_id)
    (team_id == home_team_id && winner == "home") || (team_id == away_team_id && winner == "away")
  end

  def opponent(team_id)
    teams.-([team_id])[0]
  end

  def teams
    [home_team_id, away_team_id]
  end

  def winner
    if @away_goals > @home_goals
      "away"
    elsif @away_goals < @home_goals
      "home"
    else
      "tie"
    end
  end
end
