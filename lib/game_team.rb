# frozen_string_literal: true

# GameTeam
class GameTeam
  @@game_teams = []
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

  def initialize(game_team_data)
    @game_id = game_team_data[:game_id].to_i
    @team_id = game_team_data[:team_id].to_i
    @hoa = game_team_data[:hoa]
    @result = game_team_data[:result]
    @settled_in = game_team_data[:settled_in]
    @head_coach = game_team_data[:head_coach]
    @goals = game_team_data[:goals].to_i
    @shots = game_team_data[:shots].to_i
    @tackles = game_team_data[:tackles].to_i
    @pim = game_team_data[:pim].to_i
    @power_play_opportunities = game_team_data[:powerplayopportunities].to_i
    @power_play_goals = game_team_data[:powerplaygoals].to_i
    @face_off_win_percentage = game_team_data[:faceoffwinpercentage].to_f
    @giveaways = game_team_data[:giveaways].to_i
    @takeaways = game_team_data[:takeaways].to_i
  end

  def self.create_game_teams game_teams_data
    game_teams_data.each do |game_team|
      @@game_teams << GameTeam.new(game_team)
    end
  end

  def self.game_goals
    # Returns a hash
    # keys are game ids
    # values are sum of goals in that game
    @@game_teams.reduce({}) do |game_sums, game|
      if !game_sums[game.game_id]
        game_sums[game.game_id] = 0
      end
      game_sums[game.game_id] += game.goals
      game_sums
    end
  end
end
