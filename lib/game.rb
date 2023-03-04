require 'date'

class Game

  attr_reader :info,
              :team_stats,
              :team_refs

  def initialize(game_data, team_refs)
    @info = {
      game_id: game_data[:game][:game_id],
      date_time: Date.strptime(game_data[:game][:date_time], "%D"),
      season: game_data[:game][:season],
      home_team_id: game_data[:game][:home_team_id],
      away_team_id: game_data[:game][:away_team_id],
      home_goals: game_data[:game][:home_goals].to_i,
      away_goals: game_data[:game][:away_goals].to_i,
      settled_in: game_data[:game_teams].first[:settled_in],
      venue: game_data[:game][:venue],
      venue_link: game_data[:game][:venue_link]
    }

    home_team = game_data[:game_teams].first[:team_id] == @info[:home_team_id] ?
                game_data[:game_teams].first : game_data[:game_teams].last

    away_team = game_data[:game_teams].first[:team_id] == @info[:away_team_id] ?
                game_data[:game_teams].first : game_data[:game_teams].last

    @team_stats = {
      home_team: get_team_stats(home_team),
      away_team: get_team_stats(away_team)
    }

    @team_refs = {
      home_team: team_refs[:home_team],
      away_team: team_refs[:away_team]
    }
  end

  def get_team_stats(team)
    {
      home_or_away: team[:hoa],
      result: team[:result],
      head_coach: team[:head_coach],
      goals: team[:goals].to_i,
      shots: team[:shots].to_i,
      tackles: team[:tackles].to_i,
      penalty_minutes: team[:pim].to_i,
      power_play_opportunities: team[:powerplayopportunities].to_i,
      power_play_goals: team[:powerplaygoals].to_i,
      face_off_win_percentage: team[:faceoffwinpercentage].to_f,
      giveaways: team[:giveaways].to_i,
      takeaways: team[:takeaways].to_i,
    }
  end
end
