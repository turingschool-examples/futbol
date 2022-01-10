require 'pry'
require './lib/games_teams'

class GamesTeams

attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles, :pim, :powerplayopportunities, :power_play_goals, :faceoff_win_percentage, :giveaways, :takeaways

  def initialize(data)
    @game_id = data[:game_id]
    @team_id = data[:team_id]
    @hoa = data[:hoa]
    @result = data[:result]
    @settled_in = data[:settled_in]
    @head_coach = data[:head_coach]
    @goals = data[:goals]
    @shots = data[:shots]
    @tackles = data[:tackles]
    @pim = data[:pim]
    @powerplayopportunities = data[:powerplayopportunities]
    @power_play_goals = data[:powerplaygoals]
    @faceoff_win_percentage = data[:faceoffwinpercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]
  end

  def initialize(game_teams_file)
    @game_teams_file = game_team_file
    @game_teams = self.read_self
  end

  def read_file
    data = CSV.read(@game_teams_file, headers: true, header_converter: :symbol)
    data.map do |row|
      GameTeams.new(row)
    end
  end
end
