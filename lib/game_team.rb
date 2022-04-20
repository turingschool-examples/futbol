

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

  def initialize(row)
    @game_id = row[:game_id]
    @team_id = row[:team_id]
    @hoa = row[:hoa]
    @result = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals = row[:goals]
    @shots = row[:shots]
    @tackles = row[:tackles]
    @pim = row[:pim]
    @power_play_opportunities = row[:powerplayopportunities]
    @power_play_goals = row[:powerplaygoals]
    @face_off_win_percentage = row[:faceoffwinpercentage]
    @giveaways = row[:giveaways]
    @takeaways = row[:takeaways]
  end

  def self.create_game_teams(game_teams_hash)
    game_teams_arr = []
    game_teams_hash.each do |row|
      game_teams_arr << GameTeam.new(row)
    end
    return game_teams_arr
  end
end
