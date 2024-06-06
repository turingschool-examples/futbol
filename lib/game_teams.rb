require 'csv'

class GameTeams
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
              :face_off_win_percentage,
              :give_aways,
              :take_aways

  def initialize(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, power_play_opportunities, power_play_goals, face_off_win_percentage, give_aways, take_aways)
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @settled_in = settled_in
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
    @pim = pim
    @power_play_oportunities = power_play_opportunities
    @power_play_goals = power_play_goals
    @face_off_win_percentage = face_off_win_percentage
    @give_aways = give_aways
    @take_aways = take_aways
  end

  def self.create_game_teams_data_objects(path)
    game_team_objects = []
    CSV.foreach(path, headers: true) do |row|
    game_team_objects << GameTeams.new(row["game_id"].to_i, row["team_id"].to_i, row["HoA"].to_sym, row["result"].to_sym, row["settled_in"].to_sym, row["head_coach"], row["goals"].to_i, row["shots"].to_i, row["tackles"].to_i, row["pim"].to_i, row["powerPlayOpportunities"].to_i, row["powerPlayGoals"].to_i, row["faceOffWinPercentage"].to_f, row["giveaways"].to_i, row["takeaways"].to_i)
    end
    game_team_objects
  end

end
