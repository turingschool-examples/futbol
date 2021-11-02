require './lib/stat_tracker'

class GamesData < StatTracker

  attr_reader :game_data

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    # @game_id = @game_data["game_id"]
    # @season = @game_data["season"]
    # @type = @game_data["type"]
    # @data_time = @game_data["date_time"]
    # away_team_id = @game_data["away_team_id"]
    # home_team_id = @game_data["home_team_id"]
    # away_goals = @game_data["away_goals"].to_i
    # home_goals = @game_data["home_goals"].to_i
    # venue = @game_data["venue"]
  end

  def highest_total_score
  highest_score = 0
    @game_data.each do |row|
      total_score = row['away_goals'].to_i + row['home_goals'].to_i
      if total_score > highest_score
        highest_score = total_score
      end
    end
    highest_score
  end
end
