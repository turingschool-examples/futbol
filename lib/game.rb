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
    @game_id = game_info[:game_id].to_i
    @season = game_info[:season].to_i
    @type = game_info[:type]
    @date_time = game_info[:date_time]
    @away_team_id = game_info[:away_team_id].to_i
    @home_team_id = game_info[:home_team_id].to_i
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
    @venue = game_info[:venue]
  end
  
  def average_goals_by_season
    # Need to figure out how to add all away_goals and home_goals for each season, then divide that by number of games in that season. Finally, turn that into a hash with seasons as keys, and the averages as a matching value.
    total_goals_per_game = @@all_games.map do |game|
      game.home_goals + game.away_goals
    end
    
    all_goals = total_goals_per_game.sum
    {}
  end
end
