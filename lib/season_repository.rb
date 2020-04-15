require_relative './csv_helper_file'
require_relative './repository'
require_relative './findable'

class SeasonRepository < Repository
  include Findable
  attr_reader :games_collection, :games_teams_collection, :teams_collection

  def find_game_id(season)
    game_array =  @game_collection.select do |game|
      game.season == season
      end
    game_id_array = game_array.map {|game| game.game_id}
  end

  def winningest_coach(season)
    game_id_array = find_game_id(season)
    coach_win_percentage = Hash.new(0)
    total_coach_games = coach_games(game_id_array)
    @game_team_collection.each do |team|
      if game_id_array.include?(team.game_id)
        if (team.result == "WIN")
          coach_win_percentage[team.head_coach] += (1.to_f / (total_coach_games[team.head_coach]))
        end
      end
    end
    coach_winner = coach_win_percentage.max_by{|key, value| coach_win_percentage[key]}
    coach_winner.first
  end

  def coach_games(game_array)
    coach_hash = Hash.new(0)
    @game_team_collection.each do |game_team|
      if game_array.include?(game_team.game_id)
        coach_hash[game_team.head_coach] += 1
      end
    end
    coach_hash
  end

  def worst_coach(season)
    game_id_array = find_game_id(season)
    coach_loose_percentage = Hash.new
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
  game_array = find_game_id(season_id)
      shot = Hash.new(0)
      goal = Hash.new(0)
      @game_team_collection.each do |game_team|
        if game_array.include?(game_team.game_id)
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
  game_array = find_game_id(season_id)
      shot = Hash.new(0)
      goal = Hash.new(0)
      @game_team_collection.each do |game_team|
        if game_array.include?(game_team.game_id)
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
