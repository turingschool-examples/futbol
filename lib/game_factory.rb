require 'csv'

# do we need to do this in a runner file? "The ./lib/runner.rb file is where we will be writing out code to read our files and create objects. To start, we are going to require 'CSV' so that we will have access to its methods. Next, we want to use the foreach method from CSV and pass it an argument of the file that we want to read. Similar to the each enumerable the foreach creates a block where the block variable will be a single row in the file. Now add a pry within the block so we can see what a row looks like in our block."
class GameFactory

  attr_reader :file_path
  
  def initialize(file_path)
    @file_path = file_path
    @games = []
  end

  def create_games
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      game_info = {}
      game_info[:game_id] = row[:game_id].to_i
      game_info[:season] = row[:season].to_i
      game_info[:type] = row[:type]
      game_info[:date_time] = row[:date_time]
      game_info[:away_team_id] = row[:away_team_id].to_i
      game_info[:home_team_id] = row[:home_team_id].to_i
      game_info[:away_goals] = row[:away_goals].to_i
      game_info[:home_goals] = row[:home_goals].to_i
      game_info[:venue] = row[:venue]
      game_info[:venue_link] = row[:venue_link]

      @games << Game.new(game_info)
    end
    @games
  end

  def total_score
    
    @games.map do |game|
      game.away_goals + game.home_goals
    end
  end

  # def season_games(season)

  # end

end
