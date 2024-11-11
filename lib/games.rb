require 'csv'

# The Games class represents individual game data, 
# and provides functionality to load games from a CSV file.

class Games 

    @@games_instances = []

    attr_reader :game_id, 
                :season, 
                :away_team_id, 
                :home_team_id, 
                :away_goals, 
                :home_goals

    def initialize(game_id,season,away_team_id, home_team_id, away_goals, home_goals)
      @game_id = game_id
      @season = season
      @away_team_id = away_team_id
      @home_team_id = home_team_id
      @away_goals = away_goals
      @home_goals = home_goals
    end

    def self.load_csv(game_path)
      # Iterate over each row in the CSV, converting headers to symbols for easier access
      CSV.foreach(game_path, headers: true, header_converters: :symbol) do |row|
          # Create a new Game instance for each row in the CSV and store it in @@games_instances
         @@games_instances << self.new(row[:game_id], row[:season], row[:away_team_id], row[:home_team_id], row[:away_goals].to_i, row[:home_goals].to_i)
      end
      # Return all instances loaded from the CSV, stored in @@games_instances
      @@games_instances
    end

    def self.all
      @@games_instances
    end

    def self.reset
      @@games_instances = []
    end
end
  