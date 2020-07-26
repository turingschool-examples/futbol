require_relative './game_data'
require_relative './game_team_data'
require_relative './team_data'
require_relative './game_statistics'
require_relative './league_statistics'
require_relative './season_statistics'
require 'csv'

class StatTracker

  def self.from_csv(data)
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    StatTracker.new(locations)
  end

  attr_reader :data #For testing. Eventually make a mock/stub so our test can pass without this

  def initialize(data)
    @data = data

    @game_outcomes = {
      :home_games_won => 0,
      :visitor_games_won => 0,
      :ties => 0
    }
    @all_games = all_games_creation
    @all_game_teams = all_game_teams_creation
    @all_teams = all_teams_creation

    @total_games = @all_games.size
    @games_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_goals_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_score = total_score
    @average_goals_per_season = Hash.new{}

    @team_name_by_id = Hash.new{}
    @goals_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_by_id = Hash.new{}
    @goals_by_away_id = Hash.new{ |hash, key| hash[key] = 0 }
    @goals_by_home_id = Hash.new{ |hash, key| hash[key] = 0 }

    @season_by_game_id = Hash.new{}
    @coach_by_team_id = Hash.new{}
    @team_name_by_team_id = Hash.new{}
    @total_wins_by_team_id = Hash.new{ |hash, season| hash[season] = Hash.new{ |season_string, key| season_string[key] = 0}}
    @tackles_by_team_id = Hash.new{ |hash, season| hash[season] = Hash.new{ |season_string, key| season_string[key] = 0}}

    @coach_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_objects = []
    @counter_wins_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @team_name_by_id = Hash.new{}
    @by_season_game_team_objects = []
    @goals_by_id_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    get_team_name_by_id
    @shot_accuracy_by_team_id = Hash.new
    @tackles_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }

    win_data

    get_team_name_by_id
    get_goals_by_id
    get_games_by_id
    get_goals_by_home_id
    get_goals_by_away_id
    get_average_goals_by_id

    get_season_by_game_id
    get_coach_by_team_id
    get_team_name_by_team_id
    get_total_wins_by_team_id_and_season
    get_tackles_by_team_id_and_season

  end

# ============= helper methods =============
  def all_games_creation
    GameData.create_objects
  end

  def all_game_teams_creation
    GameTeamData.create_objects
  end

  def all_teams_creation
    TeamData.create_objects
  end

  def collect_game_team_objects_by_season(season)
    all_game_teams.each do |game_team_object|
      if season.to_s[0..3] == game_team_object.game_id.to_s[0..3]
        @by_season_game_team_objects << game_team_object
      end
    end
  end

  def shots_by_team_id_by_season
    @shots_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @shots_by_team_id[season_game_team_object.team_id] += season_game_team_object.shots
    end
  end

  def goals_by_team_id_by_season
    @goals_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @goals_by_team_id[season_game_team_object.team_id] += season_game_team_object.goals
    end
  end

  def shot_accuracy_by_team_id_by_season
    @goals_by_team_id.keys.each do |key|
      shot_accuracy = @goals_by_team_id[key].to_f / @shots_by_team_id[key]
      @shot_accuracy_by_team_id[key] = shot_accuracy
    end
  end

  def tackles_by_team_id_by_season(season)
    collect_game_team_objects_by_season(season)
    @by_season_game_team_objects.each do |season_game_team_object|
      @tackles_by_team_id[season_game_team_object.team_id] += season_game_team_object.tackles
    end
  end

  def shot_accuracy_suite(season)
    collect_game_team_objects_by_season(season)
    shots_by_team_id_by_season
    goals_by_team_id_by_season
    shot_accuracy_by_team_id_by_season
  end

  def total_score
    @all_games.map do |games|
      games.home_goals.to_i + games.away_goals.to_i
    end
  end

  def create_coach_by_team_id
    all_game_teams.each do |game_by_team|
      @coach_by_team_id[game_by_team.team_id] = game_by_team.head_coach
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

  def winningest_and_worst_suite(season)
    create_coach_by_team_id
    collect_game_objects_by_season(season)
    total_wins_by_season
    best_win_percentage_by_season
    worst_win_percentage_by_season
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

  def collect_game_objects_by_season(season)
    all_games.each do |game_object|
      if season == game_object.season
        @by_season_game_objects << game_object
      end
    end
  end

  def win_data
    @all_games.each do |games|
      if games.home_goals > games.away_goals
        @game_outcomes[:home_games_won] += 1
      elsif games.home_goals < games.away_goals
        @game_outcomes[:visitor_games_won] += 1
      else
        @game_outcomes[:ties] += 1
      end
    end
  end

  def total_goals_per_season
    @all_games.each do |game|
      if @total_goals_per_season.include?(game.season)
        @total_goals_per_season[game.season] += game.away_goals.to_i + game.home_goals.to_i
      else
        @total_goals_per_season[game.season] += game.away_goals.to_i + game.home_goals.to_i
      end
    end
    @total_goals_per_season
  end

  def get_team_name_by_id
    @all_teams.each do |team|
      @team_name_by_id[team.team_id] = team.team_name
    end
  end

  def get_average_goals_by_id
    @goals_by_id.each do |team_id, goal|
      @average_goals_by_id[team_id] = (goal.to_f / @games_played_by_id[team_id]).round(2)
    end
  end

  def get_goals_by_id
    @all_game_teams.each do |game_team|
      @goals_by_id[game_team.team_id] += game_team.goals.to_i
    end
  end

  def get_games_by_id
    @all_game_teams.each do |game_team|
      @games_played_by_id[game_team.team_id] += 1
    end
  end

  def get_goals_by_away_id
    @all_game_teams.each do |game_team|
      if game_team.hoa == "away"
        @goals_by_away_id[game_team.team_id] += game_team.goals.to_i
      end
    end
  end

  def get_goals_by_home_id
    @all_game_teams.each do |game_team|
      if game_team.hoa == "home"
        @goals_by_home_id[game_team.team_id] += game_team.goals.to_i
      end
    end
  end

  def get_season_by_game_id
    @all_games.each do |game|
      @season_by_game_id[game.game_id] = game.season
    end
  end

  def get_coach_by_team_id
    @all_game_teams.each do |game_team|
      @coach_by_team_id[game_team.team_id] = game_team.head_coach
    end
  end

  def get_team_name_by_team_id
    @all_teams.each do |team|
      @team_name_by_team_id[team.team_id] = team.team_name
    end
  end

  def get_total_wins_by_team_id_and_season
    @all_games.each do |game|
      season = @season_by_game_id[game.game_id]
      if game.home_goals > game.away_goals
        @total_wins_by_team_id[season][game.home_team_id] += 1
      elsif game.home_goals < game.away_goals
        @total_wins_by_team_id[season][game.away_team_id] += 1
      end
    end
  end

  def get_tackles_by_team_id_and_season
    @all_game_teams.each do |game_teams|
      season = @season_by_game_id[game_teams.game_id]
      @tackles_by_team_id[season][game_teams.team_id] += game_teams.tackles.to_i
    end
  end
# ============= game_statistics methods =============
  def highest_total_score
    @total_score.max
  end

  def lowest_total_score
    @total_score.min
  end

  def percentage_home_wins
    home_wins = @game_outcomes[:home_games_won]
    decimal_home = home_wins.to_f / @total_games
    decimal_home.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_outcomes[:visitor_games_won]
    decimal_visitor = visitor_wins.to_f / @total_games
    decimal_visitor.round(2)
  end

  def percentage_ties
    total_ties = @game_outcomes[:ties]
    decimal_ties = total_ties.to_f / @total_games
    decimal_ties.round(2)
  end

  def count_of_games_by_season
    @all_games.each do |game|
      if @games_per_season.include?(game.season)
        @games_per_season[game.season] += 1
      else
        @games_per_season[game.season] = 1
      end
    end
    @games_per_season
  end

  def average_goals_per_game
    decimal_average = @total_score.sum.to_f / @total_games
    decimal_average.round(2)
  end

  def average_goals_by_season
    total_goals_per_season.each do |season, goals|
      average = goals.to_f / @games_per_season[season]
      @average_goals_per_season[season] = average.round(2)
    end
    @average_goals_per_season
  end
# ============= league_statistics methods =============
  def count_of_teams
    @all_teams.size
  end

  def best_offense
    best_offense_id = @average_goals_by_id.invert.max[1]
    @team_name_by_id[best_offense_id]
  end

  def worst_offense
    worst_offense_id = @average_goals_by_id.invert.min[1]
    @team_name_by_id[worst_offense_id]
  end

  def highest_scoring_visitor
    highest_scorer_away = @goals_by_away_id.invert.max[1]
    @team_name_by_id[highest_scorer_away]
  end

  def lowest_scoring_visitor
    lowest_scorer_away = @goals_by_away_id.invert.min[1]
    @team_name_by_id[lowest_scorer_away]
  end

  def highest_scoring_home_team
    highest_scorer_at_home = @goals_by_home_id.invert.max[1]
    @team_name_by_id[highest_scorer_at_home]
  end

  def lowest_scoring_home_team
    lowest_scorer_at_home = @goals_by_home_id.invert.min[1]
    @team_name_by_id[lowest_scorer_at_home]
  end
# ============= season_statistics methods =============
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
    shot_accuracy_suite(season)
    @team_name_by_id[@shot_accuracy_by_team_id.invert.max[1]]
  end

  def least_accurate_team(season)
    shot_accuracy_suite(season)
    @team_name_by_id[@shot_accuracy_by_team_id.invert.min[1]]
  end

  def most_tackles(season)
    tackles_by_team_id_by_season(season)
    @team_name_by_id[@tackles_by_team_id.invert.max[1]]
  end

  def fewest_tackles(season)
    tackles_by_team_id_by_season(season)
    @team_name_by_id[@tackles_by_team_id.invert.min[1]]
  end


# ============= team_statistics methods =============
end
