require_relative './csv_helper_file'

class SeasonRepository

  attr_reader :games_collection, :games_teams_collection, :teams_collection
  def initialize(game_path, game_team_path, team_path)
    @game_collection = CsvHelper.generate_game_array(game_path)
    @game_team_collection = CsvHelper.generate_game_teams_array(game_team_path)
    @team_collection = CsvHelper.generate_team_array(team_path)

  end
#
#  def id_stats
#    @game_team_collection.to_h{|game| [[game.game_id], [game.head_coach, game.result]]}
#  end
#require 'pry'; binding.pry
#  def tally_wins
#    require 'pry'; binding.pry
#    if @games_teams_collection.id_stats
#    end
#  end
  def winningst_coach(season)
    game_array =  @game_collection.select do |game|
      #require 'pry'; binding.pry
      game.season == season
    end
    coach_win_percentage = Hash.new
    count = 0
    game_id_array = game_array.map do |game| game.game_id
    end


    @game_team_collection.each do |team|
      game_id_array.each do |id|
      if ((team.game_id == id) && (team.result == "WIN")) && (coach_win_percentage[team.head_coach] == nil)
        #require 'pry'; binding.pry
        coach_win_percentage[team.head_coach] = 0
        coach_win_percentage[team.head_coach] += (1.to_f / (number_of_games(season, team.head_coach)))
      elsif ((team.game_id == id) && (team.result == "WIN"))
        coach_win_percentage[team.head_coach] += (1.to_f / (number_of_games(season, team.head_coach)))
      end
    end
  end
  coach_winner = coach_win_percentage.max_by{|key, value| coach_win_percentage[key]}
  coach_winner.first
  require 'pry'; binding.pry
end

    def number_of_games(season, coach)
      game_array =  @game_collection.select do |game|

        game.season == season
      end
      game_id_array = game_array.map do |game| game.game_id
      end
      count = 0

     @game_team_collection.each do |game_team|
        if  game_id_array.include?(game_team.game_id) && (game_team.head_coach == coach)
          count += 1
        end
      end
      count
    end
  end
