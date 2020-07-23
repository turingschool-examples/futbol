require 'CSV'

class GameTeam

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

  def self.from_csv(data)
    GameTeam.new(data)
  end

  def initialize(data)
    @game_id = data[0]
    @team_id = data[1]
    @hoa = data[2]
    @result = data[3]
    @settled_in = data[4]
    @head_coach = data[5]
    @goals = data[6]
    @shots = data[7]
    @tackles = data[8]
    @pim = data[9]
    @power_play_opportunities = data[10]
    @power_play_goals = data[11]
    @face_off_win_percentage = data[12]
    @giveaways = data[13]
    @takeaways = data[14]
    @gameteams = []
  end

  def team_average_goals(team_id)
    teams_by_id = @game_teams_array.select do |gameteam|
      gameteam.team_id.to_i == team_id
    end

    total_goals = teams_by_id.sum do |team|
      team.goals.to_i
    end
    (total_goals.to_f / teams_by_id.size).round(2)
  end

  def teams_sort_by_average_goal
    @game_teams_array.sort_by do |team|
      team_average_goals(team.team_id.to_i)
    end
  end

  def find_all_away_teams
     @game_teams_array.find_all do |gameteam|
      gameteam.hoa == "away"
    end
  end

  def away_games_by_team_id

    find_all_away_teams.group_by do |game|
      game.team_id
    end
  end

  def highest_visitor_team
    best_away_team = away_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end.first

    Team.all.find{|team1| team1.team_id == best_away_team}.teamname
  end

  def lowest_visitor_team
    worst_away_team = away_games_by_team_id.min_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end.first

    Team.all.find{|team1| team1.team_id == worst_away_team}.teamname
  end

  def find_all_home_teams
     @gameteams.find_all do |gameteam|
      gameteam.hoa == "home"
    end
  end

  def home_games_by_team_id

    find_all_home_teams.group_by do |game|
      game.team_id
    end
  end

  def highest_home_team
    best_home_team = home_games_by_team_id.max_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end.first

    Team.all.find{|team1| team1.team_id == best_home_team}.teamname
  end

  def lowest_home_team
    worst_home_team = home_games_by_team_id.min_by do |team_id, gameteam|
      gameteam.sum{|game1| game1.goals.to_i} / gameteam.count.to_f
    end.first

    Team.all.find{|team1| team1.team_id == worst_home_team}.teamname
  end
end
