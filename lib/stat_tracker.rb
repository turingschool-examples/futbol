require 'csv'
require './lib/game'
require './lib/team'
require './lib/season'

class StatTracker
  attr_reader

  def self.from_csv(locations)
    @games = {}
    @teams = {}
    
    games_to_create = {}
    teams_to_create = {}
    seasons_to_create = {}
    
    ######################################################
    # THESE NEED TO BE REFACTORED INTO THEIR OWN METHODS #
    # SO WE CAN ACTUALLY TEST THIS MONSTROCITY           #
    ######################################################

    CSV.foreach(locations[:teams], headers: true) do |row|
      if !teams_to_create.has_key?(row["team_id"].to_i)
        teams_to_create[row["team_id"].to_i] = {
          team_id:      row["team_id"].to_i,
          franchiseId:  row["franchiseId"].to_i,
          teamName:     row["teamName"],
          abbreviation: row["abbreviation"],
          Stadium:      row["Stadium"],
          link:         row["link"],
          games:        []
        }
      end
    end

    CSV.foreach(locations[:games], headers: true) do |row|
      if !games_to_create.has_key?(row["game_id"].to_i)
        games_to_create[row["game_id"].to_i] = {
          id:         row["game_id"].to_i,
          season:     row["season"],
          type:       row["type"],
          date_time:  row["date_time"],
          venue:      row["venue"],
          venue_link: row["venue_link"]
        }
      end
    end
  
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      team_data = {
        team_id:                  row["team_id"].to_i,
        hoa:                      row["HoA"],
        result:                   row["result"],
        head_coach:               row["head_coach"],
        goals:                    row["goals"].to_i,
        shots:                    row["shots"].to_i,
        tackles:                  row["tackles"].to_i,
        pim:                      row["pim"].to_i,
        power_play_opportunities: row["powerPlayOpportunities"].to_i,
        power_play_goals:         row["powerPlayGoals"].to_i,
        face_off_win_percentage:  row["faceOffWinPercentage"].to_f,
        giveaways:                row["giveaways"].to_i,
        takeaways:                row["takeaways"].to_i
      }
      if row["HoA"] == "home"
        games_to_create[row["game_id"].to_i][:settled_in] = row["settled_in"]
        games_to_create[row["game_id"].to_i][:home_team]  = team_data
      else
        games_to_create[row["game_id"].to_i][:settled_in] = row["settled_in"]
        games_to_create[row["game_id"].to_i][:away_team]  = team_data
      end
      
    end
    
    games_to_create.each do |key, value|
      new_game = Game.new(value)
      @games[key] = new_game

      # if !seasons_to_create.has_key?(new_game.season)
      #   teams_array = [new_game]
      #   seasons_to_create = {
      #     season: new_game.season
      #     teams: {}
      #   }
      # end

      teams_to_create[new_game.home_team[:team_id]][:games].push(new_game)
      teams_to_create[new_game.away_team[:team_id]][:games].push(new_game)
    end

    teams_to_create.each do |key, value|
      @teams[key] = Team.new(value)
    end

    # @seasons_to_create.each do |key, value|
    #   @
    # @teams.each do |team|
    #   if seasons_to_create.has_key?()
      
    require 'pry'; binding.pry
  end

end