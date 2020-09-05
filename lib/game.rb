class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals,
              :home_goals, :venue, :venue_link
  def initialize(row)
    row.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
      @away_goals = @away_goals.to_i
      @home_goals = @home_goals.to_i
  end

  def self.games_with_high_goal
    goals > 5
  end

end
