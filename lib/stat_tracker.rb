require 'csv'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class StatTracker
  attr_reader   :games,
                :teams,
                :game_teams,
                :locations
  attr_accessor :highest_total_score_stat,
                :lowest_total_score_stat,
                :percentage_home_wins,
                :percentage_visitor_wins,
                :percentage_ties,
                :count_of_games_by_season,
                :average_goals_per_game,
                :average_goals_by_season,
                :count_of_teams,
                :best_offense,
                :worst_offense,
                :highest_scoring_visitor,
                :highest_scoring_home_team,
                :lowest_scoring_visitor,
                :lowest_scoring_home_team,
                :winningest_coach,
                :worst_coach,
                :most_accurate_team,
                :least_accurate_team,
                :most_tackles,
                :fewest_tackles,
                :team_info_stat,
                :best_season,
                :worst_season,
                :average_win_percentage,
                :most_goals_scored,
                :fewest_goals_scored,
                :favorite_opponent,
                :rival

  def initialize(locations = nil)
    @locations = locations
    @games = {}
    @teams = {}
    @game_teams = {}
    csv_game_files
    csv_team_files
    csv_game_team_files
    @highest_total_score_stat  = nil
    @lowest_total_score        = nil
    @percentage_home_wins      = nil
    @percentage_visitor_wins   = nil
    @percentage_ties           = nil
    @count_of_games_by_season  = nil
    @average_goals_per_game    = nil
    @average_goals_by_season   = nil
    @count_of_teams            = nil
    @best_offense              = nil
    @worst_offense             = nil
    @highest_scoring_visitor   = nil
    @highest_scoring_home_team = nil
    @lowest_scoring_visitor    = nil
    @lowest_scoring_home_team  = nil
    @winningest_coach          = nil
    @worst_coach               = nil
    @most_accurate_team        = nil
    @least_accurate_team       = nil
    @most_tackles              = nil
    @fewest_tackles            = nil
    @team_info_stat            = nil
    @best_season               = nil
    @worst_season              = nil
    @average_win_percentage    = nil
    @most_goals_scored         = nil
    @fewest_goals_scored       = nil
    @favorite_opponent         = nil
    @rival                     = nil

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def csv_game_files
    if @locations != nil
      CSV.foreach(@locations[:games], headers: true) do |row|
        @games[row["game_id"]] = Game.new({game_id: row["game_id"],
                                            season: row["season"],
                                              type: row["type"],
                                         date_time: row["date_time"],
                                      away_team_id: row["away_team_id"],
                                      home_team_id: row["home_team_id"],
                                        away_goals: row["away_goals"],
                                        home_goals: row["home_goals"],
                                             venue: row["venue"],
                                        venue_link: row["venue_link"]})
      end
    end
  end

  def csv_team_files
    if @locations != nil
      CSV.foreach(@locations[:teams], headers: true) do |row|
        @teams[row["team_id"]] = Team.new({team_id: row["team_id"],
                                       franchiseId: row["franchiseId"],
                                         team_name: row["team_name"],
                                      abbreviation: row["abbreviation"],
                                           stadium: row["stadium"],
                                              link: row["link"]})
      end
    end
  end

  def csv_game_team_files
    if @locations != nil
      CSV.foreach(@locations[:game_teams], headers: true) do |row|
        @game_teams[row["game_id"]] = GameTeam.new({game_id: row["game_id"],
                                                    team_id: row["team_id"],
                                                        hoa: row["hoa"],
                                                     result: row["result"],
                                                 settled_in: row["settled_in"],
                                                 head_coach: row["head_coach"],
                                                      goals: row["goals"],
                                                      shots: row["shots"],
                                                    tackles: row["tackles"],
                                                        pim: row["pim"],
                                     powerPlayOpportunities: row["powerPlayOpportunities"],
                                             powerPlayGoals: row["powerPlayGoals"],
                                       faceOffWinPercentage: row["faceOffWinPercentage"],
                                                  giveaways: row["giveaways"],
                                                  takeaways: row["takeaways"]})
      end
    end
  end
end
