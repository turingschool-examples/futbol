class Game

  attr_reader :info,
              :team_stats,
              :refs

  def initialize(game_data, refs)
    @info = {
      game_id: game_data[:game][:game_id],
      date_time: game_data[:game][:date_time],
      season: game_data[:game][:season],
      home_team_id: game_data[:game][:home_team_id],
      away_team_id: game_data[:game][:away_team_id],
      home_goals: game_data[:game][:home_goals],
      away_goals: game_data[:game][:away_goals],
      settled_in: game_data[:game_teams].first[:settled_in],
      venue: game_data[:game][:venue],
      venue_link: game_data[:game][:venue_link]
    }

    home_team = game_data[:game_teams].first[:id] == @info[:home_team_id] ?
                game_data[:game_teams].first : game_data[:game_teams].last

    away_team = game_data[:game_teams].first[:id] == @info[:away_team_id] ?
                game_data[:game_teams].first : game_data[:game_teams].last

    @team_stats = {
      home_team: {
        home_or_away: home_team[:hoa],
        result: home_team[:result],
        head_coach: home_team[:head_coach],
        goals: home_team[:goals],
        shots: home_team[:shots],
        tackles: home_team[:tackles],
        penalty_minutes: home_team[:pim],
        power_play_opportunities: home_team[:powerplayopportunities],
        power_play_goals: home_team[:powerplaygoals],
        face_off_win_percentage: home_team[:faceoffwinpercentage],
        giveaways: home_team[:giveaways],
        takeaways: home_team[:takeaways],
      },
      away_team: {
        home_or_away: away_team[:hoa],
        result: away_team[:result],
        head_coach: away_team[:head_coach],
        goals: away_team[:goals],
        shots: away_team[:shots],
        tackles: away_team[:tackles],
        penalty_minutes: away_team[:pim],
        power_play_opportunities: away_team[:powerplayopportunities],
        power_play_goals: away_team[:powerplaygoals],
        face_off_win_percentage: away_team[:faceoffwinpercentage],
        giveaways: away_team[:giveaways],
        takeaways: away_team[:takeaways],
      }
    }
    @refs = {
      season: refs[:season],
      home_team: refs[:home_team],
      away_team: refs[:away_team]
    }
  end
end
