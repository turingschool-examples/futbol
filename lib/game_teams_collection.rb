require_relative './game_teams'
require 'csv'

class GameTeamsCollection

  attr_reader :game_teams_coll

  def initialize(game_teams_coll)
    @game_teams_coll = game_teams_coll
  end

  def self.all(game_teams_coll)
    all_gameteams = []
    CSV.foreach(game_teams_coll, headers: true) do |row|
      game_teams_hash =  { game_id: row["game_id"],
                          team_id: row["team_id"],
                          hoa: row["HoA"],
                          result: row["result"],
                          settled_in: row["settled_in"],
                          head_coach: row["head_coach"],
                          goals: row["goals"],
                          shots: row["shots"],
                          tackles: row["tackles"],
                          pim: row["pim"],
                          powerplayqopportunities: row["powerPlayOpportunities"],
                          powerplaygoals: row["powerPlayGoals"],
                          faceoffwinpercentage: row["faceOffWinPercentage"],
                          giveaways: row["giveaways"],
                          takeaways: row["takeaways"] }
      all_gameteams << GameTeams.new(game_teams_hash)
    end
    all_gameteams
  end

end
