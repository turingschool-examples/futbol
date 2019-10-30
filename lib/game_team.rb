require 'csv'

class GameTeam
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim,
              :power_play_opportunities, :power_play_goals, :face_off_win_percentage, :giveaways, :takeaways

  def initialize(game_id, team_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim,
                  powerplayppportunities, powerplaygoals, faceoffwinpercentage, giveaways, takeaways)
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
    @power_play_opportunities = powerplayppportunities
    @power_play_goals = powerplaygoals
    @face_off_win_percentage = faceoffwinpercentage
    @giveaways = giveaways
    @takeaways = takeaways
  end

  def self.create(file_path)
    @game_teams = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @game_teams << self.new(row[:game_id],
                                    row[:team_id],
                                    row[:hoa],
                                    row[:result],
                                    row[:settled_in],
                                    row[:head_coach],
                                    row[:goals].to_i,
                                    row[:shots].to_i,
                                    row[:tackles],
                                    row[:pim],
                                    row[:powerplayopportunities],
                                    row[:powerplaygoals],
                                    row[:faceoffwinpercentage],
                                    row[:giveaways],
                                    row[:takeaways],)
    end
    @game_teams
  end

end
