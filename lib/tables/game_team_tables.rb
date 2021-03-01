require './lib/helper_modules/csv_to_hashable'
require './lib/helper_modules/team_returnable'
require './lib/instances/game_team'
require './lib/helper_modules/team_returnable'
require './lib/helper_modules/averageable'

class GameTeamTable
  include CsvToHash
  include ReturnTeamable
  include Averageable

  attr_reader :game_team_data, :teams, :stat_tracker

  def initialize(locations)
    @game_team_data = from_csv(locations, 'GameTeam')
    @stat_tracker = stat_tracker
  end

  def winningest_coach(season)
    games_by_season = games_by_season(season)
    winning_coach_hash = games_by_season.group_by do |game|
       game.head_coach if game.result == "WIN"
    end
    win_count = winning_coach_hash.each { |k, v| winning_coach_hash[k] = v.count}.reject{|coach| coach == nil}
    win_count.max_by{|coach, win| win}[0]
  end

  def worst_coach(season)
    games_by_season = games_by_season(season)
    winning_coach_hash = games_by_season.group_by do |game|
       game.head_coach if game.result == "LOSS"
      end
    win_count = winning_coach_hash.each { |k, v| winning_coach_hash[k] = v.count}.reject{|coach| coach == nil}
    win_count.min_by{|coach, win| win}[0]
  end

  def most_accurate_team(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by {|game| game.team_id}
    ratio_of_g_to_s = games_by_team_id_hash.each do |team, ratio|
      games_by_team_id_hash[team] = ratio.map do |array|
        (array.goals.to_f / array.shots.to_f).round(2)
      end
    end
    r1 = ratio_of_g_to_s.max_by do |team_id, ratio|
      ratio.sum
    end
    r1[0]
  end

  def least_accurate_team(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by {|game| game.team_id}
    ratio_of_g_to_s = games_by_team_id_hash.each do |team, ratio|
      games_by_team_id_hash[team] = ratio.map do |array|
        (array.goals.to_f / array.shots.to_f).round(2)
      end
    end
    r1 = ratio_of_g_to_s.min_by do |team_id, ratio|
      ratio.sum
    end
    r1[0]
  end

  def most_tackles(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by {|game| game.team_id}
    container = games_by_team_id_hash.each do |team, games|
      games_by_team_id_hash[team] = games.sum do |lul|
        lul.tackles
      end
    end
    thereturn = container.max_by do |team_id, tackle|
      tackle
    end
    thereturn[0]
  end

  def fewest_tackles(season)
    games_by_season = games_by_season(season)
    games_by_team_id_hash = games_by_season.group_by {|game| game.team_id}
    container = games_by_team_id_hash.each do |team, games|
      games_by_team_id_hash[team] = games.sum do |lul|
        lul.tackles
      end
    end
    thereturn = container.min_by do |team_id, tackle|
      tackle
    end
    thereturn[0]
  end

  def game_by_season
    season = @game_data.group_by do |game|
      game.season
    end
  end
  def games_by_season(season)
    season = @stat_tracker.game_by_season[season.to_i].map do |season|
      season.game_id
    end
    ids = @game_team_data.map do |gameteam|
      gameteam.game_id
    end
    overlap = season & ids
  end

  def worst_offense
    hash = Hash.new
    #groups games by team_id, then adds the team_id as key to goal_hash with average goals per game as value
    @game_team_data.group_by{|game| game.team_id}.map {|team| hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    #finds the minimum score, return the team_id of team with min score
    hash.min_by {|team| team[1]}[0]
  end

  def highest_scoring_home_team
    hash = Hash.new
    #finds all home games, groups them by team, takes the
    @game_team_data.find_all {|game| game.hoa == 'home' }.group_by{|game| game.team_id}.map{|team| hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    hash.max_by {|team| team[1]}[0]
  end
  def lowest_scoring_home_team
    hash = Hash.new
    #finds all home games, groups them by team, takes the
    @game_team_data.find_all {|game| game.hoa == 'home' }.group_by{|game| game.team_id}.map{|team| hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    hash.min_by {|team| team[1]}[0]
  end
  def worst_season(team_id)
    array = []
    hash = Hash.new()
    @game_team_data.find_all{|game| game.team_id == team_id}.map{|game| array << [game.game_id, game.result]}
    array = array.group_by{|line| line[0].to_s.split('')[0..3].join}
    array.map{|season| hash[season[0]] = season[1].find_all{|game| game[1] == 'WIN'}.length.to_f / season[1].length}
    hash.min_by {|team| team[1]}[0]
  end

  def most_goals_scored(team_id_str)
    #find all the games for that team, then takes max by goals scored and returns the goals from the object
    @game_team_data.find_all{|game| game.team_id == team_id_str.to_i}.max_by{|game| game.goals}.goals
  end
  def find_team_games(team_id_str)
    @game_team_data.find_all{|game| game.team_id == team_id_str.to_i}
  end


  def best_offense
    best_offense_hash = Hash.new
    @game_team_data.group_by{|game| game.team_id}.map {|team| best_offense_hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    best_offense_hash.max_by {|team| team[1]}[0]
  end

  def highest_scoring_visitor
    visitor_hash = Hash.new
    @game_team_data.find_all {|game| game.hoa == 'away' }.group_by{|game| game.team_id}.map{|team| visitor_hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    visitor_hash.max_by {|team| team[1]}[0]
  end

  def lowest_scoring_visitor
    lowest_vis_hash = Hash.new
    @game_team_data.find_all {|game| game.hoa == 'away' }.group_by{|game| game.team_id}.map{|team| lowest_vis_hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    lowest_vis_hash.min_by {|team| team[1]}[0]
  end

  def average_win_percentage(team_id)
    id_int = team_id.to_i
    win_percent = 0
    total_games = 0
    @game_team_data.each do |game|
      win_percent += 1 if (game.team_id == id_int) && (game.result == "WIN")
      total_games += 1 if (game.team_id == id_int)
    end
    (win_percent.to_f / total_games).round(2)
  end

  def best_season(team_id)
    array = []
    hash = Hash.new()
    @game_team_data.find_all{|game| game.team_id == team_id}.map{|game| array << [game.game_id, game.result]}
    array = array.group_by{|line| line[0].to_s.split('')[0..3].join}
    array.map{|season| hash[season[0]] = season[1].find_all{|game| game[1] == 'WIN'}.length.to_f / season[1].length}
    hash.max_by {|team| team[1]}[0]
  end

  def fewest_goals_scored(team_id_str)
    @game_team_data.find_all{|game| game.team_id == team_id_str.to_i}.min_by{|game| game.goals}.goals
  end

end
