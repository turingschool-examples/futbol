class GameTeams
  @@gameteams = []
  attr_reader :team_id, :goals

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @HoA = info[:hoa]
    @result = info[:result]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @tackles = info[:tackles]
    @pim = info[:pim]
    @power_play_opportunities = info[:powerplayopportunities]
    @power_play_goals = info[:powerplaygoals]
    @face_off_win_percent = info[:faceoffwinpercentage]
    @giveaways = info[:giveaways]
    @takeaways = info[:takeaways]
  end

  def self.add(game_team)
    @@gameteams << game_team
  end

  def self.all
    @@gameteams
  end

  def self.remove_all
    @@gameteams = []
  end
end
