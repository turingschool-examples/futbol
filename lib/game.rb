class Game
attr_reader :id,
            :season,
            :type,
            :date_time,
            :away,
            :home,
            :away_goals,
            :home_goals,
            :venue,
            :venue_link

  def initialize(id, season, type, date_time, away, home, away_goals, home_goals, venue, venue_link)
    @id = id
    @season = season
    @type = type
    @date_time = date_time
    @away = away
    @home = home
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue_link
  end
end