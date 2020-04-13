require_relative './csv_helper_file'

class SeasonRepository

  attr_reader :games_collection, :games_teams_collection, :teams_collection
  def initialize(game_path, game_team_path, team_path)
    @game_collection = CsvHelper.generate_game_array(game_path)
    @game_team_collection = CsvHelper.generate_game_teams_array(game_team_path)
    @team_collection = CsvHelper.generate_team_array(team_path)

  end

  def winningst_coach(season)
    game_array =  @game_collection.select do |game|
      game.season == season
      end
    coach_win_percentage = Hash.new
    #count = 0
    game_id_array = game_array.map do |game| game.game_id
      end

    @game_team_collection.each do |team|
      game_id_array.each do |id|
      if ((team.game_id == id) && (team.result == "WIN")) && (coach_win_percentage[team.head_coach] == nil)
        coach_win_percentage[team.head_coach] = 0
        coach_win_percentage[team.head_coach] += (1.to_f / (number_of_games(season, team.head_coach)))
      elsif ((team.game_id == id) && (team.result == "WIN"))
        coach_win_percentage[team.head_coach] += (1.to_f / (number_of_games(season, team.head_coach)))
      end
    end
  end
    coach_winner = coach_win_percentage.max_by{|key, value| coach_win_percentage[key]}
    coach_winner.first

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

  def worst_coach(season)
    game_array =  @game_collection.select do |game|
      game.season == season
      end
    coach_loose_percentage = Hash.new
    #count = 0
    game_id_array = game_array.map do |game| game.game_id
      end

    @game_team_collection.each do |team|
      game_id_array.each do |id|
      if ((team.game_id == id) && (team.result == "LOSS")) && (coach_loose_percentage[team.head_coach] == nil)
        coach_loose_percentage[team.head_coach] = 0
        coach_loose_percentage[team.head_coach] += (1.to_f / (number_of_games(season, team.head_coach)))
      elsif ((team.game_id == id) && (team.result == "LOSS"))
        coach_loose_percentage[team.head_coach] += (1.to_f / (number_of_games(season, team.head_coach)))
      end
     end
    end
    coach_looser = coach_loose_percentage.max_by{|key, value| coach_loose_percentage[key]}
    coach_looser.first
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


def most_tackles(season_id)
  games_in_the_season = []
  tackles_team = {}
  @game_collection.each do |game|
    if game.season == season_id
      games_in_the_season << game.game_id
    end
  end
  games_in_the_season.each do |season_game|
    @game_team_collection.each do |game_team|
      if game_team.game_id == season_game
        if tackles_team.key?(game_team.team_id)
          tackles_team[game_team.team_id] += game_team.tackles
        else
          tackles_team[game_team.team_id] = game_team.tackles
        end
      end
    end
  end
  team_id_to_find = tackles_team.sort_by { |key, value| value }.last[0]
  find_team_id(team_id_to_find)
end

def fewest_tackles(season_id)
  games_in_the_season = []
  tackles_team = {}
  @game_collection.each do |game|
    if game.season == season_id
      games_in_the_season << game.game_id
    end
  end
  games_in_the_season.each do |season_game|
    @game_team_collection.each do |game_team|
      if game_team.game_id == season_game
        if tackles_team.key?(game_team.team_id)
          tackles_team[game_team.team_id] += game_team.tackles
        else
          tackles_team[game_team.team_id] = game_team.tackles
        end
      end
    end
  end
  team_id_to_find = tackles_team.sort_by { |key, value| value }.first[0]
  find_team_id(team_id_to_find)
end

def find_team_id(id)
  found_team = @team_collection.find do |team|
    team.team_id == id
  end
  named_team = found_team.teamname
  named_team
end


end
