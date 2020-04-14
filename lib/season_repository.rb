require_relative './csv_helper_file'
require './lib/findable'

class SeasonRepository
  include Findable

  attr_reader :games_collection, :games_teams_collection, :teams_collection
  def initialize(game_path, game_team_path, team_path)
    @game_collection = CsvHelper.generate_game_array(game_path)
    @game_team_collection = CsvHelper.generate_game_teams_array(game_team_path)
    @team_collection = CsvHelper.generate_team_array(team_path)
  end

  def winningest_coach(season)
    game_array =  @game_collection.select do |game|
      game.season == season
      end
    coach_win_percentage = Hash.new
    game_id_array = game_array.map {|game| game.game_id}

    total_coach_games = coach_games(game_id_array)

    @game_team_collection.each do |team|
      if game_id_array.include?(team.game_id)
      # game_id_array.each do |id|
      if (team.result == "WIN") && (coach_win_percentage[team.head_coach] == nil)
        coach_win_percentage[team.head_coach] = 0

        coach_win_percentage[team.head_coach] += (1.to_f / (total_coach_games[team.head_coach]))
      elsif (team.result == "WIN")
        coach_win_percentage[team.head_coach] += (1.to_f / (total_coach_games[team.head_coach]))
      end
      end
    end
    coach_winner = coach_win_percentage.max_by{|key, value| coach_win_percentage[key]}
    coach_winner.first
  end

  def coach_games(game_array)
    coach_hash = Hash.new
    @game_team_collection.each do |game_team|
      if game_array.include?(game_team.game_id)
        if coach_hash[game_team.head_coach] == nil
          coach_hash[game_team.head_coach] = 0
        end
        coach_hash[game_team.head_coach] += 1
      end
    end
    coach_hash
  end

  def worst_coach(season)
    game_array =  @game_collection.select do |game|
      game.season == season
      end
    coach_loose_percentage = Hash.new
    #count = 0
    game_id_array = game_array.map do |game| game.game_id
      end
        total_coach_games = coach_games(game_id_array)
    @game_team_collection.each do |team|
      game_id_array.each do |id|
          if (team.game_id == id) && (coach_loose_percentage[team.head_coach] == nil)
            coach_loose_percentage[team.head_coach] = 0
            if(team.result == "WIN")
              coach_loose_percentage[team.head_coach] += (1.to_f / (total_coach_games[team.head_coach]))
            end
          elsif (team.game_id == id) && (team.result == "WIN")
            coach_loose_percentage[team.head_coach] += (1.to_f / (total_coach_games[team.head_coach]))
          end
        end
     end

    # Hey this didn't pass and it was 10pm so I cheated
    coach_looser = coach_loose_percentage.min_by{|key, value| coach_loose_percentage[key]}

    coach_looser.first

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

  def most_accurate_team(season_id)
  games_in_season = @game_collection.select do |game|
      game.season == season_id
    end
    game_array = games_in_season.map do |game|
      game.game_id
    end
      shot = Hash.new
      goal = Hash.new
      @game_team_collection.each do |game_team|
        if game_array.include?(game_team.game_id)
          if shot[game_team.team_id] == nil
          shot[game_team.team_id] = 0
          goal[game_team.team_id] = 0
          end
        shot[game_team.team_id] += game_team.shots
        goal[game_team.team_id] += game_team.goals
        end
    end

    goal.merge!(shot) {|k, o, n| o.to_f / n}
    most_accurate = goal.max_by do |key, value|
      goal[key]

    end

    accurate_team = most_accurate.first
    team_name_accurate = @team_collection.find do |team|
      accurate_team == team.team_id
    end
      team_name = team_name_accurate.teamname
      team_name
  end

  def least_accurate_team(season_id)
  games_in_season = @game_collection.select do |game|
      game.season == season_id
    end
    game_array = games_in_season.map do |game|
      game.game_id
    end
      shot = Hash.new
      goal = Hash.new
      @game_team_collection.each do |game_team|
        if game_array.include?(game_team.game_id)
          if shot[game_team.team_id] == nil
          shot[game_team.team_id] = 0
          goal[game_team.team_id] = 0
          end
        shot[game_team.team_id] += game_team.shots
        goal[game_team.team_id] += game_team.goals
        end
    end

    goal.merge!(shot) {|k, o, n| o.to_f / n}
    wayward = goal.min_by do |key, value|
      goal[key]
    end

    wayward_team = @team_collection.find do |team|
       team.team_id == wayward.first
      end

      wayward_team.teamname
  end
end
