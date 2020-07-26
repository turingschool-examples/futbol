require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"

class SeasonStatistics

  def initialize
    @coach_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_objects = []
  end

  def all_teams
    TeamData.create_objects
  end

  def all_games
    GameData.create_objects
  end

  def all_game_teams
    GameTeamData.create_objects
  end

  def create_coach_by_team_id
    all_game_teams.each do |game_by_team|
      @coach_by_team_id[game_by_team.team_id] = game_by_team.head_coach
    end
    @coach_by_team_id
  end

  def collect_game_objects_by_season
    all_games.each do |game_object|
      if season == game_object.season
        @by_season_game_objects << game_object
      end
    end
    @by_season_game_objects
  end

  def total_wins_by_season
    @counter_wins_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }

    @by_season_game_objects.each do |season_game_object|
      @games_played_by_team_id[season_game_object.away_team_id] += 1
      @games_played_by_team_id[season_game_object.home_team_id] += 1

      if season_game_object.home_goals > season_game_object.away_goals
        @counter_wins_team_id[season_game_object.home_team_id] += 1
        @counter_wins_team_id[season_game_object.away_team_id] += 0
      elsif season_game_object.away_goals > season_game_object.home_goals
        @counter_wins_team_id[season_game_object.away_team_id] += 1
        @counter_wins_team_id[season_game_object.home_team_id] += 0
      end
    end
    @games_played_by_team_id
    @counter_wins_team_id
  end

  def win_percentage_by_season
    most_number_of_games_won = @counter_wins_team_id.invert.max[0].to_f
    for_highest_total_games_played = @games_played_by_team_id[@counter_wins_team_id.invert.max[1]]
    least_number_of_games_won = @counter_wins_team_id.invert.min[0].to_f
    for_lowest_total_games_played = @games_played_by_team_id[@counter_wins_team_id.invert.min[1]]

    winningest = (most_number_of_games_won / for_highest_total_games_played) * 100
    worst = (least_number_of_games_won / for_lowest_total_games_played) * 100
  end

  def winningest_and_worst_suite
    create_coach_by_team_id
    collect_game_objects_by_season
    total_wins_by_season
    win_percentage_by_season
  end

  def winningest_coach(season)
    winningest_and_worst_suite
    max_team_id = @counter_wins_team_id.invert.max[1]
    winningest_coach = @coach_by_team_id[max_team_id]
  end

  def worst_coach(season)
    winningest_and_worst_suite
    min_team_id = @counter_wins_team_id.invert.min[1]
    worst_coach = @coach_by_team_id[min_team_id]
  end

end
