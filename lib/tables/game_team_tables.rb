require './lib/helper_modules/csv_to_hashable'
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
    season = @stat_tracker.game_by_season[20132014].map do |season|
      season.game_id
    end
    #wins count / winnings seasons count
    #need to get wins count by each coach

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
end
