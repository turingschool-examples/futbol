class LeagueStats
  attr_reader :game_data,
              :team_data,
              :games_teams

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    @team_data = current_stat_tracker.teams
    @games_teams = current_stat_tracker.games_teams
  end

  def count_of_teams
    @team_data.count
  end

  def all_teams_ids
    team_id = []
    @games_teams.each do |row|
      team_id << row['team_id']
    end
    team_id.uniq
  end

  def average_goals_per_team(team_id)
    game_counter = 0
    goals_per_game = []
    @games_teams.each do |row|
      if row['team_id'].to_i == team_id
        goals_per_game << row['goals'].to_i
        game_counter += 1
      end
    end
    (goals_per_game.sum.to_f / game_counter).round(2)
  end

  # def best_offense
  #   team_goal_hash = {}
  #   team_id = all_teams_ids
  #   team_id.each do |id|
  #     team_goal_hash[id] =
  #   end
  #   team_goal_hash
  #   count = []
  #   team_id.each do |team|
  #     @games_teams.each do |row|
  #       if row['team_id'] == team
  #         count << row['goals']
  #       end
  #     end
  #   end
  #   count
  # end
end
