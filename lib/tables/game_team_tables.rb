require './lib/helper_modules/csv_to_hashable'
require './lib/instances/game_team'
require './lib/helper_modules/team_returnable'

class GameTeamTable
  include CsvToHash
  include ReturnTeamable
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
    #require "pry"; binding.pry

  end

  def worst_offense
    goal_hash = Hash.new
    #groups games by team_id, then adds the team_id as key to goal_hash with average goals per game as value
    @game_team_data.group_by{|game| game.team_id}.map {|team| goal_hash[team[0]] = team[1].map{|game| game.goals}.sum.to_f / team[1].length}
    #finds the minimum score, return the team_id of team with min score
    goal_hash.min_by {|team| team[1]}[0]
  end

  def highest_scoring_home_team
    @game_team_data.find_all {|game| game.HoA }
  end
end
