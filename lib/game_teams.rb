class GameTeams
  attr_reader :team_id, :goals, :hoa, :teamname

  @@gameteams = []

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @hoa = info[:hoa]
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

  def self.find_all_away_teams
     @@gameteams.find_all do |gameteam|
      gameteam.hoa == "away"
    end
  end

  def self.away_games_by_team_id

    find_all_away_teams.group_by do |game|
      game.team_id
    end
  end

  def self.highest_visitor_team
    best_away_team = away_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f

    end.first

    Team.all.find{|team1| team1.team_id == best_away_team}.teamname
  end

  def self.find_all_home_teams
     @@gameteams.find_all do |gameteam|
      gameteam.hoa == "home"
    end
  end

  def self.home_games_by_team_id

    find_all_home_teams.group_by do |game|
      game.team_id
    end
  end

  def self.highest_home_team
    best_home_team = home_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f

    end.first

    Team.all.find{|team1| team1.team_id == best_home_team}.teamname
  end
end
