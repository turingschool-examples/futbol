require 'csv'

class Game
  @@all_games

  def self.all_games
    @@all_games
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all_games = csv.map do |row|
                    Game.new(row)
                  end
  end

attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue

  def initialize(game_info)
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
  end
  
  def self.count_of_games_by_season
    
    season_games = {}
    number_of_games = 0
    
    all_games_sorted = @@all_games.sort_by(&:season)
    
    all_games_sorted.each do |game|
      if season_games.keys.include?(game.season) == false
        number_of_games = 0
        season_games[game.season] = (number_of_games += 1)
      else
        season_games[game.season] = (number_of_games += 1)
      end
    end
    
    season_games
  end
  
  def self.average_goals_by_season
    # Need to figure out how to add all away_goals and home_goals for each season, then divide that by number of games in that season. Finally, turn that into a hash with seasons as keys, and the averages as a matching value.
    seasons = @@all_games.map do |game|
      game.season
    end.uniq
        
    total_goals_per_game = @@all_games.map do |game|
      game.home_goals + game.away_goals
    end
    
    all_goals = total_goals_per_game.sum
    {}
  end
end
