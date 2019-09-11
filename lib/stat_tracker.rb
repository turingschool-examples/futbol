require 'csv'
require_relative './game'
require_relative './team'
require_relative './season'
require_relative './modules/gameable'
require_relative './modules/leagueable'
require_relative './modules/teamable'
require_relative './modules/seasonable'


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
    seasons_to_create = {}
    
    CSV.foreach(locations[:teams], headers: true) do |line|
      if !teams_to_create.has_key?(line["team_id"])
        teams_to_create[line["team_id"]] = create_team_hash(line)
      end
    end

    CSV.foreach(locations[:games], headers: true) do |line|
      if !games_to_create.has_key?(line["game_id"])
        games_to_create[line["game_id"]] = create_game_hash(line)
      end
    end
  
    CSV.foreach(locations[:game_teams], headers: true) do |line|
      team_data = create_game_team_hash(line)
      id = line["game_id"]
      games_to_create[id][:settled_in] = line["settled_in"]

      if line["HoA"] == "home"
        games_to_create[id][:home_team] = team_data
      else
        games_to_create[id][:away_team] = team_data
      end
    end

    games_to_create.each do |key, game_data|
      new_game = Game.new(game_data)
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

  def self.create_team_hash(team_line)
    {
      team_id:      team_line["team_id"],
      franchiseId:  team_line["franchiseId"],
      teamName:     team_line["teamName"],
      abbreviation: team_line["abbreviation"],
      Stadium:      team_line["Stadium"],
      link:         team_line["link"],
      games:        {}
    }
  end

  def self.create_game_hash(game_line)
    {
      id:         game_line["game_id"],
      season:     game_line["season"],
      type:       game_line["type"],
      date_time:  game_line["date_time"],
      venue:      game_line["venue"],
      venue_link: game_line["venue_link"]
    }
  end

  def self.create_game_team_hash(game_team_line)
    {
      id:                       game_team_line["team_id"],
      hoa:                      game_team_line["HoA"],
      result:                   game_team_line["result"],
      head_coach:               game_team_line["head_coach"],
      goals:                    game_team_line["goals"].to_i,
      shots:                    game_team_line["shots"].to_i,
      tackles:                  game_team_line["tackles"].to_i,
      pim:                      game_team_line["pim"].to_i,
      power_play_opportunities: game_team_line["powerPlayOpportunities"].to_i,
      power_play_goals:         game_team_line["powerPlayGoals"].to_i,
      face_off_win_percentage:  game_team_line["faceOffWinPercentage"].to_f,
      giveaways:                game_team_line["giveaways"].to_i,
      takeaways:                game_team_line["takeaways"].to_i
    }
  end

end