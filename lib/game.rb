class Game
  attr_reader :data
  
  def initialize(stats)
    @data = {
      :game_id => stats[0].to_i,
      :season => stats[1].to_i,
      :type => stats[2],
      :date_time => stats[3],
      :away_team_id => stats[4].to_i,
      :home_team_id => stats[5].to_i,
      :away_goals => stats[6].to_i,
      :home_goals => stats[7].to_i,
      :venue => stats[8],
      :venue_link => stats[9]
    }
  end
end
