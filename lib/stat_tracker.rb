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
                                 # require "pry"; binding.pry
  end

end
# advatanges of a hash:
  # - can look up information rigt away

# games_table = CSV.parse(File.read(locations[:games], headers: true))
#   # if games[games_table][counter].nil?
# require "pry"; binding.pry
#   # end

  # CSV.foreach(locations[:games], headers: true) do |row|
  #   require "pry"; binding.pry
  #   @games[row["game_id"]] = Game.new({game_id: row["game_id"],
  #                                    season: row["season"],
  #                                      type: row["type"],
  #                                 date_time: row["date_time"],
  #                              away_team_id: row["away_team_id"],
  #                              home_team_id: row["home_team_id"],
  #                                away_goals: row["away_goals"],
  #                                home_goals: row["home_goals"],
  #                                     venue: row["venue"],
  #                                venue_link: row["venue_link"]})
# every loop run, it would replace the value every time it assigned a value.
# no accumalative array. Finished with nil value from the last run.

#
