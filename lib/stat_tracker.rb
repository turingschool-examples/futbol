require 'csv'
require_relative 'game_statistics'
require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class StatTracker
  include GameStatistics
  attr_reader   :game_table,
                :team_table,
                :game_team_table,
                :locations

  def initialize(locations = nil)
    @locations = locations
    @game_table = {}
    @team_table = {}
    @game_team_table = []
    csv_game_files
    csv_team_files
    csv_game_team_files
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def csv_game_files
    if @locations[:games]
      CSV.foreach(@locations[:games], headers: true) do |row|
        @game_table[row["game_id"]] = Game.new(row)
      end
    end
  end

  def csv_team_files
    if @locations[:teams]
      CSV.foreach(@locations[:teams], headers: true) do |row|
        @team_table[row["team_id"]] = Team.new({team_id: row["team_id"],
                                       franchiseId: row["franchiseId"],
                                         team_name: row["team_name"],
                                      abbreviation: row["abbreviation"],
                                           stadium: row["stadium"],
                                              link: row["link"]})
      end
    end
  end

  def csv_game_team_files
    if @locations[:game_teams]
      CSV.foreach(@locations[:game_teams], headers: true) do |row|
        @game_team_table << GameTeam.new({game_id: row["game_id"],
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
