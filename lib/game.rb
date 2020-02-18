class Game
  attr_reader :id
              :season
              :type
              :date_time
              :away_team_id
              :home_team_id
              :away_goals
              :home_goals
              :venue
              :venue_link

  def initialize(game_data)
    @id             = game_data[:id]
    @season         = game_data[:season].to_i
    @type           = game_data[:type]
    @date_time      = game_data[:date_time]
    @away_team_id   = game_data[:away_team_id]
    @home_team_id   = game_data[:home_team_id]
    @away_goals     = game_data[:away_goals]
    @home_goals     = game_data[:home_goals]
    @venue          = game_data[:venue]
    @venue_link     = game_data[:venue_link]
  end

  def average_goals_per_game
		total_goals = Game.all.map {|game| game.total_score}
		return ((total_goals.sum.to_f / Game.length).round(2))
	end
end
