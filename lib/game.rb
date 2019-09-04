class Game

  attr_reader :id,
              :season,
              :type,
              :date_time,
              :settled_in,
              :venue,
              :venue_link,
              :home_team,
              :away_team

  def initialize(game_hash)
    @id = game_hash[:id]
    @season = game_hash[:season]
    @type = game_hash[:type]
    @date_time = game_hash[:date_time]
    @settled_in = game_hash[:settled_in]
    @venue = game_hash[:venue]
    @venue_link = game_hash[:venue_link]
    @home_team = {
      team_id: game_hash[:home_team][:team_id],
      hoa: game_hash[:home_team][:hoa],
      result: game_hash[:home_team][:result],
      head_coach: game_hash[:home_team][:head_coach],
      goals: game_hash[:home_team][:goals],
      shots: game_hash[:home_team][:shots],
      tackles: game_hash[:home_team][:tackles],
      pim: game_hash[:home_team][:pim],
      power_play_opportunities: game_hash[:home_team][:power_play_opportunities],
      power_play_goals: game_hash[:home_team][:power_play_goals],
      face_off_win_percentage: game_hash[:home_team][:face_off_win_percentage],
      giveaways: game_hash[:home_team][:giveaways],
      takeaways: game_hash[:home_team][:takeaways]
    }
    @away_team = {
      team_id: game_hash[:away_team][:team_id],
      hoa: game_hash[:away_team][:hoa],
      result: game_hash[:away_team][:result],
      head_coach: game_hash[:away_team][:head_coach],
      goals: game_hash[:away_team][:goals],
      shots: game_hash[:away_team][:shots],
      tackles: game_hash[:away_team][:tackles],
      pim: game_hash[:away_team][:pim],
      power_play_opportunities: game_hash[:away_team][:power_play_opportunities],
      power_play_goals: game_hash[:away_team][:power_play_goals],
      face_off_win_percentage: game_hash[:away_team][:face_off_win_percentage],
      giveaways: game_hash[:away_team][:giveaways],
      takeaways: game_hash[:away_team][:takeaways]
    }
  end
end
