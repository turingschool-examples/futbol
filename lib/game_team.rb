require 'csv'

class GameTeam
  attr_reader :manager,
              :game_id,
              :team_id,
              :home_or_away,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :penalties_in_minutes,
              :power_play_opportunities,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize(data, manager)
    @manager = manager
    @game_id = data['game_id']
    @team_id = data['team_id']
    @home_or_away = data['HoA']
    @result = data['result']
    @settled_in = data['settled_in']
    @head_coach = data['head_coach']
    @goals = data['goals']
    @shots = data['shots']
    @tackles = data['tackles']
    @penalties_in_minutes = data['pim']
    @power_play_opportunities = data['powerPlayOpportunities']
    @power_play_goals = data['powerPlayGoals']
    @face_off_win_percentage = data['faceOffWinPercentage']
    @giveaways = data['giveaways']
    @takeaways = data['takeaways']
  end
end
