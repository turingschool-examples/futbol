require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def self.from_csv(locations)
    games = games_csv(locations)
    teams = teams_csv(locations)
    game_teams = game_teams_csv(locations)
    self.new(games, teams, game_teams)
  end

  def self.games_csv(locations)
    games = []
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |info|
      games << Game.new(info)
    end
    games
  end

  def self.teams_csv(locations)
    teams = []
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |info|
      teams << Team.new(info)
    end
    teams
  end

  def self.game_teams_csv(locations)
    game_teams = []
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |info|
      game_teams << GameTeam.new(info)
    end
    game_teams
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
      @game_id = info[:game_id]
      @season = info[:season]
      @type = info[:type]
      @date_time = info[:date_time]
      @away_team_id = info[:away_team_id]
      @home_team_id = info[:home_team_id]
      @away_goals = info[:away_goals]
      @home_goals = info[:home_goals]
      @venue = info[:venue]
      @venue_link = info[:venue_link]
    end

    def goals_per_game
      away_goals.to_i + home_goals.to_i
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
      @team_id = info[:team_id]
      @franchise_id = info[:franchiseid]
      @team_name = info[:teamname]
      @abbreviation = info[:abbreviation]
      @stadium = info[:stadium]
      @link = info[:link]
    end
  end

  class GameTeam
    attr_reader :game_id,
                :team_id,
                :hoa,
                :result,
                :settled_in,
                :head_coach,
                :goals,
                :shots,
                :tackles,
                :pim,
                :power_play_opportunities,
                :power_play_goals,
                :face_off_win_percentage,
                :giveaways,
                :takeaways

    def initialize(info)
      @game_id = info[:game_id]
      @team_id = info[:team_id]
      @hoa = info[:hoa]
      @result = info[:result]
      @settled_in = info[:settled_in]
      @head_coach = info[:head_coach]
      @goals = info[:goals]
      @shots = info[:shots]
      @tackles = info[:tackles]
      @pim = info[:pim]
      @power_play_opportunities = info[:powerplayopportunities]
      @power_play_goals = info[:powerplaygoals]
      @face_off_win_percentage = info[:faceoffwinpercentage]
      @giveaways = info[:giveaways]
      @takeaways = info[:takeaways]
    end
  end
  

  ## GAME STATISTIC METHODS

    def average_goals_per_game
      total_goals = games.reduce(0) do |sum, game|
        sum + game.goals_per_game
      end

      (total_goals.to_f/games.length).round(2)
    end

    #Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
    def count_of_games_by_season
      hash = {}

      seasons = games.map do |game|
        game.season
      end.uniq.sort

      seasons.each do |season|
        hash[season] = []
      end
      
      games.each do |game|
        hash[game.season] << game
      end

      hash.each do |k, v|
        hash[k] = v.count
      end

      hash
    end
    
    def average_goals_by_season
      hash = count_of_games_by_season
      
      hash.each do |k, v|
        hash[k] = (goals_per_season(k, v)/v.to_f).round(2)
      end

      hash
    end

    def goals_per_season(season, num_games)
      goal_counter = 0
      games.each do |game|
        if game.season == season
          goal_counter += game.goals_per_game 
        end
      end
      goal_counter
    end
  
end