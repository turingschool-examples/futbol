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
  highest_tackles = 0
  highest_team_id = 0
  @game_collection.each do |game|
    if game.season == season_id
      games_in_the_season << game.game_id
    end
  end
  games_in_the_season.each do |season_game|
    @game_team_collection.each do |game_team|
      if game_team.game_id == season_game
        if game_team.tackles > highest_tackles
          highest_tackles = game_team.tackles
          highest_team_id = game_team.team_id
        end
      end
    end
  end
  find_team_id(highest_team_id)
end

def fewest_tackles(season_id)
  games_in_the_season = []
  lowest_tackles = 100
  lowest_team_id = 100
  @game_collection.each do |game|
    if game.season == season_id
      games_in_the_season << game.game_id
    end
  end
  games_in_the_season.each do |season_game|
    @game_team_collection.each do |game_team|
      if game_team.game_id == season_game
        if game_team.tackles < lowest_tackles
          lowest_tackles = game_team.tackles
          lowest_team_id = game_team.team_id
        end
      end
    end
  end
  find_team_id(lowest_team_id)
end

def find_team_id(id)
  found_team = @team_collection.find do |team|
    team.team_id == id
  end
  named_team = found_team.teamname
  named_team
end

def most_accurate_team(season_id)

games_in_season = @game_collection.select do |game|

    game.season == season_id
  end
  game_array = games_in_season.map do |game|
    game.game_id
  end
    game_array

    shot = Hash.new
    goal = Hash.new


    @game_team_collection.each do |game_team|

      if game_array.include?(game_team.game_id)
  # require"pry";binding.pry
        if shot[game_team.team_id] == nil
          # require"pry";binding.pry
        shot[game_team.team_id] = 0
        goal[game_team.team_id] = 0
        end
      shot[game_team.team_id] += game_team.shots
      goal[game_team.team_id] += game_team.goals
    end
  end
  shot
  goal
  goal.merge!(shot) {|k, o, n| o.to_f / n}

  most_accurate = goal.max_by do |key, value|
    goal[key]
  end
  most_accurate.first
require"pry";binding.pry
end

end
def divide_two_array values
  a = {a: 1, b: 2, c: 3}
  b = {a: 2, c: 4, b: 3}
  a.merge!(b) { |k, o, n| o + n }
  a # => {:a=>3, :b=>5, :c=>7}




end
