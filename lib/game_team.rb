class GameTeam
  @@game_teams = {}

  def self.add(game_team)
    #hash[game_id]
      #hash[teams] of teams that played in game
        #GameTeam object

    #hash[team_id]
      #GameTeam objects that have team_id
    @@game_teams[game_team.game_id] = {} if !@@game_teams.has_key?(game_team.game_id)
    @@game_teams[game_team.game_id][game_team.team_id] = game_team
  end

  def self.all
    @@game_teams
  end

  def self.game_teams=(value)
    @@game_teams = value
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
    @power_play_opportunities = data[:powerplayopportunities]
    @power_play_goals = data[:powerplaygoals]
    @face_off_win_percentage = data[:faceoffwinpercentage]
    @giveaways = data[:giveaways]
    @takeaways = data[:takeaways]
  end

end
