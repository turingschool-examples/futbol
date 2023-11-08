require 'CSV'
require './spec/spec_helper'

#comment

class GameTeams
  attr_reader :array

  def initialize
    @array = []
    array_fill
  end

  def array_fill 
    CSV.foreach('./data/game_teams.csv', headers: true, header_converters: :symbol) do |row|
      game_id                  = row[:game_id].to_i
      team_id                  = row[:team_id].to_i
      hoa                      = row[:hoa].to_s
      result                   = row[:result].to_s
      settled_in               = row[:settled_in].to_s
      head_coach               = row[:head_coach].to_s
      goals                    = row[:goals].to_i
      shots                    = row[:shots].to_i
      tackles                  = row[:tackles].to_i
      pim                      = row[:pim].to_i
      power_play_opportunities = row[:powerplayopportunities].to_i
      power_play_goals         = row[:powerplaygoals].to_i
      face_off_win_percentage  = row[:faceoffwinpercentage].to_f
      giveaways                = row[:giveaways].to_i
      takeaways                = row[:takeaways].to_i

      new_game_team = GameTeam.new(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, power_play_opportunities, power_play_goals, face_off_win_percentage, giveaways, tackles)

      @array.append(new_game_team)
    end
  end
end
