require 'csv'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @games = {}
    CSV.foreach(locations[:games], headers: true) do |row|

      @games[row["game_id"]] = Game.new({game_id: row["game_id"],
                                          season: row["season"],
                                            type: row["type"],
                                       date_time: row["date_time"],
                                    away_team_id: row["away_team_id"],
                                    home_team_id: row["home_team_id"],
                                      away_goals: row["away_goals"],
                                      home_goals: row["home_goals"],
                                           venue: row["venue"],
                                      venue_link: row["venue_link"]})

                                 end
  end

end
