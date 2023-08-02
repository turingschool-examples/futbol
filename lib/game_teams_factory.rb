#./lib/games_teams_factory.rb
require "csv"

class GameTeamsFactory
  attr_reader :game_teams

  def initialize
    @game_teams = []
  end

  def create_game_teams(database)
    contents = CSV.open database, headers: true, header_converters: :symbol

    @game_teams = contents.map do |game_team|
      game_id = game_team[:game_id].to_i
      team_id = game_team[:team_id].to_i
      hoa = game_team[:hoa]
      result = game_team[:result]
      settled_in = game_team[:settled_in]
      head_coach = game_team[:head_coach]
      goals = game_team[:goals].to_i
      shots = game_team[:shots].to_i
      tackles = game_team[:tackles].to_i
      pim = game_team[:pim].to_i
      power_play_opportunities = game_team[:powerplayopportunities].to_i
      power_play_goals = game_team[:powerplaygoals].to_i
      face_off_win_percentage = game_team[:faceoffwinpercentage].to_f
      giveaways = game_team[:giveaways].to_i
      takeaways = game_team[:takeaways].to_i

      GameTeams.new(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, power_play_opportunities, power_play_goals, face_off_win_percentage, giveaways, takeaways)
    end
  end
end