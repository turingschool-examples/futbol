class GameTeam
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
              :giveaways,
              :takeaways

  def initialize(data)
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @hoa = data[:hoa]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals].to_i
    @shots = data[:shots].to_i
    @tackles = data[:tackles].to_i
    @pim = data[:pim].to_i
    @power_play_opportunities = data[:powerplayopportunities].to_i
    @power_play_goals = data[:powerplaygoals].to_i
    @face_off_win_percentage = data[:faceoffwinpercentage].to_f
    @giveaways = data[:giveaways].to_i
    @takeaways = data[:takeaways].to_i
  end
end
# class GameTeamsParser
#   def self.parse(file_path)
#     CSV.read(file_path, headers: true).map do |row|
#       {
#         game_id: row['game_id'],
#         team_id: row['team_id'],
#         hoa: row['HoA'],
#         result: row['result'],
#         settled_in: row['settled_in'],
#         head_coach: row['head_coach'],
#         goals: row['goals'].to_i,
#         shots: row['shots'].to_i,
#         tackles: row['tackles'].to_i,
#         pim: row['pim'].to_i,
#         power_play_opportunities: row['powerPlayOpportunities'].to_i,
#         power_play_goals: row['powerPlayGoals'].to_i,
#         face_off_win_percentage: row['faceOffWinPercentage'].to_f,
#         giveaways: row['giveaways'].to_i,
#         takeaways: row['takeaways'].to_i
#       }
#     end
#   end
# end
