require 'csv'

class Teams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunities,
              :power_play_goals,
              :faceoff_win_percent,
              :giveaways,
              :takeaways

  def initialize(row)
    @game_id = row["game_id"].to_i
    @team_id = row["team_id"].to_i
    @hoa = row["HoA"]
    @result = row["result"]
    @settled_in = row["settled_in"]
    @head_coach = row["head_coach"]
    @goals = row["goals"].to_i
    @shots = row["shots"].to_i
    @tackles = row["tacles"].to_i
    @pim = row["pim"].to_i
    @power_play_opportunities = row["powerPlayOpportunities"].to_i
    @power_play_goals = row["powerPlayGoals"].to_i
    @faceoff_win_percent = row["faceOffWinPercentage"].to_f
    @giveaways = row["giveaways"].to_i
    @takeaways = row["giveaways"].to_i
  end

  # module, maybe?
  def self.file(file)
    rows = CSV.read(file, headers: true)
    rows.map do |row|
      new(row)
    end
  end
end