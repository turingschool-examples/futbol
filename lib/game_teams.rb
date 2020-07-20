class GameTeams
  attr_reader :team_id, :goals

  @@gameteams = []


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
    @@team = []
  end

  def self.team_average_goals(team_id)
    teams_by_id = @@gameteams.find_all do |gameteam|
      gameteam.team_id.to_i == team_id
    end

    total_goals = teams_by_id.sum do |teams|
      teams.goals.to_i
    end
    (total_goals.to_f / teams_by_id.size).round(2)
  end

  def self.teams_sort_by_average_goal
    Team.all.sort_by do |team|
      team_average_goals(team.team_id.to_i)
    end
  end
end
