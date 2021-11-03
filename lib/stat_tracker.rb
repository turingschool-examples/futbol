
require "pry"
require 'csv'

class StatTracker


  attr_accessor :games_array, :game_id, :season, :type, :date_time, :away_team_id,
    :home_team_id, :away_goals, :home_goals, :venue, :venue_link,

    :teams_array, :team_id, :franchiseId, :teamName, :abbreviation,
    :stadium, :link,

    :game_teams_array, :gt_game_id, :gt_team_id, :gt_HoA, :gt_result, :gt_settled_in, :gt_head_coach,
    :gt_goals, :gt_shots, :gt_tackles, :gt_pim, :gt_powerPlayOpportunities,
    :gt_powerPlayGoals, :gt_faceOffWinPercentage, :gt_giveaways, :gt_takeaways

  def initialize()
    @games_array = []
    @game_id = []
    @season = []
    @type = []
    @date_time = []
    @away_team_id = []
    @home_team_id = []
    @away_goals = []
    @home_goals = []
    @venue = []
    @venue_link = []

    @teams_array = []
    @team_id = []
    @franchiseId = []
    @teamName = []
    @abbreviation = []
    @stadium = []
    @link = []

    @game_teams_array = []
    @gt_game_id = []
    @gt_team_id = []
    @gt_HoA = []
    @gt_result =[]
    @gt_settled_in = []
    @gt_head_coach = []
    @gt_goals = []
    @gt_shots = []
    @gt_tackles = []
    @gt_pim = []
    @gt_powerPlayOpportunities = []
    @gt_powerPlayGoals = []
    @gt_faceOffWinPercentage = []
    @gt_giveaways = []
    @gt_takeaways = []

  end


  def self.from_csv(filenames)


    stat_tracker = StatTracker.new()


    stat_tracker.games_array = CSV.read(filenames[:games], headers: true)

    stat_tracker.games_array.each do |array|
      stat_tracker.game_id << array[0]
      stat_tracker.season << array[1]
      stat_tracker.type << array[2]
      stat_tracker.date_time << array[3]
      stat_tracker.away_team_id << array[4]
      stat_tracker.home_team_id << array[5]
      stat_tracker.away_goals << array[6].to_i
      stat_tracker.home_goals << array[7].to_i
      stat_tracker.venue << array[8]
      stat_tracker.venue_link << array[9]
    end

    stat_tracker.teams_array = CSV.read(filenames[:teams], headers: true)
    stat_tracker.teams_array.each do |array|
      stat_tracker.team_id << array[0]
      stat_tracker.franchiseId << array[1]
      stat_tracker.teamName << array[2]
      stat_tracker.abbreviation << array[3]
      stat_tracker.stadium << array[4]
      stat_tracker.link << array[5]

    end

    # require "pry"; binding.pry

    stat_tracker.game_teams_array = CSV.read(filenames[:game_teams], headers: true)
    stat_tracker.game_teams_array.each do |array|
      stat_tracker.gt_game_id << array[0]
      stat_tracker.gt_team_id << array[1]
      stat_tracker.gt_HoA << array[2]
      stat_tracker.gt_result << array[3]
      stat_tracker.gt_settled_in << array[4]
      stat_tracker.gt_head_coach << array[5]
      stat_tracker.gt_goals << array[6]
      stat_tracker.gt_shots << array[7]
      stat_tracker.gt_tackles << array[8]
      stat_tracker.gt_pim << array[9]
      stat_tracker.gt_powerPlayOpportunities << array[10]
      stat_tracker.gt_powerPlayGoals << array[11]
      stat_tracker.gt_faceOffWinPercentage << array[12]
      stat_tracker.gt_giveaways << array[13]
      stat_tracker.gt_takeaways << array[14]

    end

    return stat_tracker

  end



  def highest_total_score
    max_total_score = 0
    sum = 0

    for i in 0..@away_goals.length-1 do
      sum = @away_goals[i] + @home_goals[i]
      if sum > max_total_score
        max_total_score = sum
      end
    end

    return max_total_score
  end


  def count_of_games_by_season
    @season.tally
  end

  def count_of_teams
    @team_id.count
  end

end
