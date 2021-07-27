require 'csv'

class Games
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(row)
    @game_id = row["game_id"].to_i
    @season = row["season"].to_i
    @type = row["date_time"]
    @date_time = row["date_time"]
    @away_team_id = row["away_team_id"].to_i
    @home_team_id = row["home_team_id"].to_i
    @away_goals = row["away_goals"].to_i
    @home_goals = row["home_goals"].to_i
    @venue = row["venue"]
    @venue_link = row["venue_link"]
  end

  # module, maybe?
  def self.file(file)
    rows = CSV.read(file, headers: true)
    rows.map do |row|
      new(row)
    end
  end
end