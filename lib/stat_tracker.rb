class StatTracker
  attr_reader

  def self.from_csv(locations)
    @games = {}
    @teams = {}

    games_to_create = {}

    CSV.foreach(locations[:games], headers: true) do |row|
      if !games_to_create.has_key?(row["game_id"].to_i)
        games_to_create[row["game_id"].to_i] = {
          id: row["game_id"].to_i,
          season: row["season"],
          type: row["type"],
          date_time: row["date_time"],
          venue: row["venue"],
          venue_link: row["venue_link"]
        }
      end
    end
  
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      team_data = {
        team_id: row["team_id"].to_i,
        hoa: row["HoA"],
        result: row["result"],
        head_coach: row["head_coach"],
        goals: row["goals"].to_i,
        shots: row["shots"].to_i,
        tackles: row["tackles"].to_i,
        pim: row["pim"].to_i,
        power_play_opportunities: row["powerPlayOpportunities"].to_i,
        power_play_goals: row["powerPlayGoals"].to_i,
        face_off_win_percentage: row["faceOffWinPercentage"].to_f,
        giveaways: row["giveaways"].to_i,
        takeaways: row["takeaways"].to_i
      }
      if row["HoA"] == "home"
        games_to_create[row["game_id"].to_i][:settled_in] = row["settled_in"]
        games_to_create[row["game_id"].to_i][:home_team] = team_data
      else
        games_to_create[row["game_id"].to_i][:settled_in] = row["settled_in"]
        games_to_create[row["game_id"].to_i][:away_team] = team_data
      end
      
    end
    
    games_to_create.each do |key, value|
      @games[key] = Game.new(value)
    end

    # Now we need to get teams stuff
  end

end