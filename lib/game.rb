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
    @game_id = data[:game_id].to_i
    @season = data[:season].to_i
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
    @venue = data[:venue]
    @venue_link = data[:venue_link]
  end

  def total_score
    @away_goals + @home_goals
  end

  # add methods as much as possible: ratio?

  def winner
    if @home_goals > @away_goals
      :home
    elsif @away_goals > @home_goals
      :visitor
    else
      :tie
    end
  end

  def winning_team_score
    if winner == :home
      @home_goals
    elsif winner == :away
      @away_goals
    else winner == :tie
      "Game tie: #{@home_goals}-#{@away_goals}."
    end
  end

  def losing_team_score
    if winner == :home
      @away_goals
    elsif winner == :away
      @home_goals
    else winner == :tie
      "Game tie: #{@home_goals}-#{@away_goals}."
    end
  end
end
