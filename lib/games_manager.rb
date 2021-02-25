class Games
  attr_reader :away_goals,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize( game_id,
                  season,
                  type,
                  date_time,
                  away_team_id,
                  home_team_id,
                  away_goals,
                  home_goals,
                  venue,
                  venue_link)
    @game_id = game_id
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals.to_i
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue_link
  end

  def self.highest_total_score(games)
    scores = @games.flat_map do |game|
      [game.away_goals.to_i + game.home_goals.to_i]
    end
    scores.max
  end
end
