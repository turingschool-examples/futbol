require 'csv'

class GameTeams
  attr_reader :info

  def initialize(data)
    @info = {
      game_id: data[:game_id].to_i,
      team_id: data[:team_id].to_i,
      hoa: data[:hoa],
      result: data[:result],
      settled_in: data[:settled_in],
      head_coach: data[:head_coach],
      goals: data[:goals].to_i,
      shots: data[:shots].to_i,
      tackles: data[:tackles].to_i,
      pim: data[:pim].to_i,
      power_play_opportunities: data[:powerplayopportunities].to_i,
      power_play_goals: data[:powerplaygoals].to_i,
      face_off_win_percentage: data[:faceoffwinpercentage].to_f,
      giveaways: data[:giveaways].to_i,
      takeaways: data[:takeaways].to_i }
  end

  def self.create_game_teams(game_teams_data)
    game_teams = []
    CSV.foreach game_teams_data, headers: true, header_converters: :symbol do |row|
      game_teams << GameTeams.new(row)
    end
    game_teams
  end
end