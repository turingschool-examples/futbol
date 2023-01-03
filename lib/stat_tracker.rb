require 'csv'

class StatTracker
  attr_reader :games

  def initialize

  end
  
  def self.from_csv(locations)
    games_csv(locations)
    require 'pry'; binding.pry
    teams_csv(locations)
    game_teams_csv(locations)
    
  end

  def self.games_csv(locations)
    games = []
    CSV.foreach(locations[:games], headers: true) do |info|
      games << Game.new(info)
    end
    games
  end

  def self.teams_csv(locations)
    teams = []
    CSV.foreach(locations[:teams], headers: true) do |info|
      teams << Team.new(info)
    end
    teams
  end

  class Game
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

    def initialize(info)
      @game_id = info["game_id"]
      @season = info["season"]
      @type = info["type"]
      @date_time = info["date_time"]
      @away_team_id = info["away_team_id"]
      @home_team_id = info["home_team_id"]
      @away_goals = info["away_goals"]
      @home_goals = info["home_goals"]
      @venue = info["venue"]
      @venue_link = info["venue_link"]
    end
  end

  class Team
    attr_reader :team_id,
                :franchise_id,
                :team_name,
                :abbreviation,
                :stadium,
                :link
                
    def initialize(info)
      @team_id = info["team_id"]
      @franchise_id = info["franchiseId"]
      @team_name = info["teamName"]
      @abbreviation = info["abbreviation"]
      @stadium = info["Stadium"]
      @link = info["link"]
    end
  end
  
end