require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"
require_relative "league_statistics"

class SeasonStatistics < LeagueStatistics

  def initialize
    @coach_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_objects = []
    @counter_wins_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @team_name_by_id = Hash.new{}
    @by_season_game_team_objects = []
    @goals_by_id_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    get_team_name_by_id
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
  end

  def collect_game_objects_by_season(season)
    all_games.each do |game_object|
      if season == game_object.season
        @by_season_game_objects << game_object
      end
    end
  end

  def total_games_played_by_season(game)
    @games_played_by_team_id[game.away_team_id] += 1
    @games_played_by_team_id[game.home_team_id] += 1
  end

  def total_wins_for_home(game)
    @counter_wins_team_id[game.home_team_id] += 1
    @counter_wins_team_id[game.away_team_id] += 0
  end

  def total_wins_for_away(game)
    @counter_wins_team_id[game.away_team_id] += 1
    @counter_wins_team_id[game.home_team_id] += 0
  end

  def total_wins_by_season
    @by_season_game_objects.each do |season_game_object|
      total_games_played_by_season(season_game_object)
      if season_game_object.home_goals > season_game_object.away_goals
        total_wins_for_home(season_game_object)
      elsif season_game_object.away_goals > season_game_object.home_goals
        total_wins_for_away(season_game_object)
      end
    end
  end

  def best_win_percentage_by_season
    most_number_of_games_won = @counter_wins_team_id.invert.max[0].to_f
    for_highest_total_games_played = @games_played_by_team_id[@counter_wins_team_id.invert.max[1]]
    winningest = (most_number_of_games_won / for_highest_total_games_played) * 100
  end

  def worst_win_percentage_by_season
    least_number_of_games_won = @counter_wins_team_id.invert.min[0].to_f
    for_lowest_total_games_played = @games_played_by_team_id[@counter_wins_team_id.invert.min[1]]
    worst = (least_number_of_games_won / for_lowest_total_games_played) * 100
  end

  def winningest_and_worst_suite(season)
    create_coach_by_team_id
    collect_game_objects_by_season(season)
    total_wins_by_season
    best_win_percentage_by_season
    worst_win_percentage_by_season
  end

  def winningest_coach(season)
    winningest_and_worst_suite(season)
    max_team_id = @counter_wins_team_id.invert.max[1]
    winningest_coach = @coach_by_team_id[max_team_id]
  end

  def worst_coach(season)
    winningest_and_worst_suite(season)
    min_team_id = @counter_wins_team_id.invert.min[1]
    worst_coach = @coach_by_team_id[min_team_id]
  end

  def most_accurate_team(season)
    all_game_teams.each do |game_team_object|
      if season.to_s[0..3] == game_team_object.game_id.to_s[0..3]
        @by_season_game_team_objects << game_team_object
      end
    end
    @shots_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @shots_by_team_id[season_game_team_object.team_id] += season_game_team_object.shots
    end
    @goals_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @goals_by_team_id[season_game_team_object.team_id] += season_game_team_object.goals
    end
    @shot_accuracy_by_team_id = Hash.new
      @goals_by_team_id.keys.each do |key|
        shot_accuracy = @goals_by_team_id[key].to_f / @shots_by_team_id[key]
        @shot_accuracy_by_team_id[key] = shot_accuracy
      end
      @team_name_by_id[@shot_accuracy_by_team_id.invert.max[1]]

  end

end
