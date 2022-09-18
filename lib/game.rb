class Game
  attr_reader :info
  
  def initialize(info)
    @info = {info[0].to_sym => {
      season: info[1],
      type: info[2],
      date_time: info[3],
      away_team_id: info[4],
      home_team_id: info[5],
      away_goals: info[6],
      home_goals: info[7],
      venue: info[8],
      venue_link: info[9]
      }}
  end
end