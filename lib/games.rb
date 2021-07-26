class Game

  def initialize(stats)
    @data = {
      :game_id => stats[0],
      :season => stats[1],
      :type => stats[2],
      :date_time => stats[3],
      :away_team_id => stats[4],
      :home_team_id => stats[5],
      :away_goals => stats[6],
      :home_goals => stats[7],
      :venue => stats[8],
      :venue_link => stats[9]
    }
  end
end
