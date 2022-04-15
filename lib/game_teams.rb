class GameTeams
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals,
    :shots, :tackles, :pim, :power_play_opportunities, :power_play_goals,
    :face_off_win_percentage, :giveaways, :takeaways

  def initialize(game_id, team_id, hoa, result, settled_in, head_coach, goals,
    shots, tackles, pim, power_play_opportunities, power_play_goals,
    face_off_win_percentage, giveaways, takeaways)
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
    @power_play_opportunities = power_play_opportunities
    @power_play_goals = power_play_goals
    @face_off_win_percentage = face_off_win_percentage
    @giveaways = giveaways
    @takeaways = takeaways
  end

  def self.fill_game_teams_array(data)
    game_teams_data = []
    data.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals].to_i
      shots = row[:shots].to_i
      tackles = row[:tackles].to_i
      pim = row[:pim].to_i
      power_play_opportunities = row[:powerplayopportunities].to_i
      power_play_goals = row[:powerplaygoals].to_i
      face_off_win_percentage = row[:faceoffwinpercentage].to_i
      giveaways = row[:giveaways].to_i
      takeaways = row[:takeaways].to_i
      game_teams_data << GameTeams.new(game_id, team_id, hoa, result, settled_in, head_coach, goals,
        shots, tackles, pim, power_play_opportunities, power_play_goals,
        face_off_win_percentage, giveaways, takeaways)
      end
      game_teams_data
  end


end
