require 'csv'
require './lib/game'
require './lib/team'
require './lib/season'
require './lib/modules/gameable'
require './lib/modules/leagueable'
require './lib/modules/teamable'
require './lib/modules/seasonable'


class StatTracker
  attr_reader :games, :teams, :seasons

  include Gameable
  include Leagueable
  include Teamable
  include Seasonable

  def initialize
    @games = {}
    @teams = {}
    @seasons = {}
  end
  
  
  def self.from_csv(locations)
    stat_tracker = self.new
    
    games_to_create = {}
    teams_to_create = {}
    team_seasons = {}
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
          games:        {}
        }
      end
    end

    CSV.foreach(locations[:games], headers: true) do |row|
      if !games_to_create.has_key?(row["game_id"].to_i)
        games_to_create[row["game_id"].to_i] = {
          id:         row["game_id"].to_i,
          season:     row["season"].to_i,
          type:       row["type"],
          date_time:  row["date_time"],
          venue:      row["venue"],
          venue_link: row["venue_link"]
        }
      end
    end
  
    CSV.foreach(locations[:game_teams], headers: true) do |row|
      team_data = {
        id:                       row["team_id"].to_i,
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

    games_to_create.each do |key, game|
      new_game = Game.new(game)
      stat_tracker.games[key] = new_game

      teams_to_create[new_game.home_team[:id]][:games][new_game.id] = new_game
      teams_to_create[new_game.away_team[:id]][:games][new_game.id] = new_game

      if !seasons_to_create.has_key?(new_game.season)
        seasons_to_create[new_game.season] = {
          season_id: new_game.season,
          teams: {}
        }
      end
    end

    teams_to_create.each do |key, value|
      stat_tracker.teams[key] = Team.new(value)
    end

    stat_tracker.games.values.each do |game|
      ##############################################################################################
      # The Marshal in these if statements makes a deep copy of the team and all of its attributes #
      # This was done so we can delete all games not relevant to the season                        #
      ##############################################################################################
      if !seasons_to_create[game.season][:teams].has_key?(game.home_team[:id])
        home_team_serialized = Marshal.dump(stat_tracker.teams[game.home_team[:id]].dup)
        home_team = Marshal.load(home_team_serialized)
        home_team.games.keep_if { |game_id, game_obj| game_obj.season == game.season }
        seasons_to_create[game.season][:teams][game.home_team[:id]] = home_team
      end

      if !seasons_to_create[game.season][:teams].has_key?(game.away_team[:id])
        away_team_serialized = Marshal.dump(stat_tracker.teams[game.away_team[:id]].dup)
        away_team = Marshal.load(away_team_serialized)
        away_team.games.keep_if { |game_id, game_obj| game_obj.season == game.season }
        seasons_to_create[game.season][:teams][game.away_team[:id]] = away_team
      end
    end

    seasons_to_create.each do |season_id, season|
      stat_tracker.seasons[season_id] = Season.new(season)
    end

    stat_tracker
  end
end