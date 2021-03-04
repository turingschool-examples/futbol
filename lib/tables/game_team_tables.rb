require_relative '../helper_modules/csv_to_hashable'
require_relative '../instances/game_team'
require_relative '../helper_modules/team_returnable'
require_relative '../helper_modules/averageable'

class GameTeamTable
  include CsvToHash
  include ReturnTeamable
  include Averageable

  attr_reader :game_team_data, :teams, :stat_tracker

  def initialize(locations)
    @game_team_data = from_csv(locations, 'GameTeam')

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
    hash = Hash.new
    teams_hash = games_by_season.group_by {|game| game.team_id}
    teams_hash.map{|key, value| hash[key] = value.map{|game| game.goals.to_f / game.shots}.sum / value.length}
  hash.max_by{|h| h[1]}[0]
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
      games_by_team_id_hash[team] = games.sum do |game|
        game.tackles
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
      games_by_team_id_hash[team] = games.sum do |game|
        game.tackles
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
  def games_by_season(season) # takes in a string argument, returns all of the games for that season
    @game_team_data.find_all{|game| game.game_id.to_s[0..3] == season[0..3]}
  end

  def worst_offense
    hash = Hash.new
    @game_team_data.group_by{|game| game.team_id}.map {|team| hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    hash.min_by {|team| team[1]}[0]
  end

  def best_offense
    best_offense_hash = Hash.new
    @game_team_data.group_by{|game| game.team_id}.map {|team| best_offense_hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    best_offense_hash.max_by {|team| team[1]}[0]
  end

  def highest_scoring_home_team
    hash = Hash.new

    @game_team_data.find_all {|game| game.hoa == 'home' }.group_by{|game| game.team_id}.map{|team| hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    hash.max_by {|team| team[1]}[0]
  end

  def lowest_scoring_home_team
    hash = Hash.new
    @game_team_data.find_all {|game| game.hoa == 'home' }.group_by{|game| game.team_id}.map{|team| hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    hash.min_by {|team| team[1]}[0]
  end

  def worst_season(team_id)
    array = []
    hash = Hash.new()
    @game_team_data.find_all{|game| game.team_id == team_id.to_i}.map{|game| array << [game.game_id, game.result]}
    array = array.group_by{|line| line[0].to_s.split('')[0..3].join}
    array.map{|season| hash[season[0]] = season[1].find_all{|game| game[1] == 'WIN'}.length.to_f / season[1].length}
    year = (hash.min_by {|team| team[1]}[0]).to_i
  end

  def best_season(team_id)
    array = []
    team_id =team_id.to_i
    hash = Hash.new()
    @game_team_data.find_all{|game| game.team_id == team_id.to_i}.map{|game| array << [game.game_id, game.result]}
    array = array.group_by{|line| line[0].to_s.split('')[0..3].join}
    array.map{|season| hash[season[0]] = season[1].find_all{|game| game[1] == 'WIN'}.length.to_f / season[1].length}
    year = (hash.max_by {|team| team[1]}[0]).to_i
    year.to_s + (year + 1).to_s
  end

  def most_goals_scored(team_id_str)
    @game_team_data.find_all{|game| game.team_id == team_id_str.to_i}.max_by{|game| game.goals}.goals
  end
  def find_team_games(team_id_str)
    @game_team_data.find_all{|game| game.team_id == team_id_str.to_i}
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
    team_id = team_id.to_i
    games_played = @game_team_data.find_all{|game| game.team_id == team_id}
    (games_played.find_all{|game| game.result == 'WIN'}.length.to_f / games_played.length).round(2)
  end

  def fewest_goals_scored(team_id_str)
    @game_team_data.find_all{|game| game.team_id == team_id_str.to_i}.min_by{|game| game.goals}.goals
  end
end
