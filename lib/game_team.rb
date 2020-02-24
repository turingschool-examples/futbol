require 'csv'

class GameTeam

  @@all = []

  def self.create_game_teams(csv_file_path)
    csv = CSV.read(csv_file_path, headers: true, header_converters: :symbol)

    all_game_team = csv.map do |row|
      GameTeam.new(row)
    end

    @@all = all_game_team
  end

  def self.all
    @@all
  end

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

  def initialize(game_team_parameter)
    @game_id = game_team_parameter[:game_id].to_i
    @team_id = game_team_parameter[:team_id].to_i
    @hoa = game_team_parameter[:hoa]
    @result = game_team_parameter[:result]
    @settled_in = game_team_parameter[:settled_in]
    @head_coach = game_team_parameter[:head_coach]
    @goals = game_team_parameter[:goals].to_i
    @shots = game_team_parameter[:shots].to_i
    @tackles = game_team_parameter[:tackles].to_i
    @pim = game_team_parameter[:pim].to_i
    @power_play_opportunities = game_team_parameter[:powerplayopportunities].to_i
    @power_play_goals = game_team_parameter[:powerplaygoals].to_i
    @face_off_win_percentage = game_team_parameter[:faceoffwinpercentage].to_f
    @giveaways = game_team_parameter[:giveaways].to_i
    @takeaways = game_team_parameter[:takeaways].to_i
    # aggregate team with goals scored
    # aggregate team w goals scored against then
  end

end
