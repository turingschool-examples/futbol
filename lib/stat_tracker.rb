require 'CSV'
require './runner'
class StatTracker

  def self.from_csv(locations)

    CSV.foreach('./data/games.csv', headers: true) do |row|
        @game_id = row["game_id"].to_i
        @season = row["season"].to_i
        @type = row["type"]
        @date_time = row["date_time"]
        @away_team_id = row["away_team_id"].to_i
        @home_team_id = row["home_team_id"].to_i
        @away_goals = row["away_goals"].to_i
        @home_goals = row["home_goals"].to_i
        @venue = row["venue"]
        @venue_link = row["venue_link"]
        require "pry"; binding.pry
    end
  end

  def highest_total_score

    test1 = []
    row.each do |row|
      test = @home_goals + @away_goals
      test1 << test
      # go through each game and tally home and away goals. display highest sum of goals as integer
    end
    test1.max
  end
end
