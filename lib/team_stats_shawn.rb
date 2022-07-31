class TeamStats
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def best_season(search_team_id)
    ((season_stats(search_team_id).tally.values.sort.last.to_f / @data.games.count) * 100).round(2).to_s
  end

  def worst_season(search_team_id)
    ((season_stats(search_team_id).tally.values.sort.first.to_f / @data.games.count) * 100).round(2).to_s
  end

  def most_goals_scored(search_team_id)
    goals_scored(search_team_id).sort.last.to_i
  end

  def favorite_opponent(search_team_id)
    team_id = opponent_name(search_team_id).last.first
    team_name = ""
    @data.teams.each do |team|
      if team[:team_id] == team_id
        team_name << team[:teamname]
      end
    end
    team_name
  end

  def rival(serach_team_id)
    team_id = opponent_name(search_team_id).first.first
    team_name = ""
    @data.teams.each do |team|
      if team[:team_id] == team_id
        team_name << team[:teamname]
      end
    end
    team_name
  end
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  def season_stats(search_team_id)

    all_win_info = []
      @data.game_teams.each do |game_team|
        if game_team[:result] == "WIN" && game_team[:team_id] == search_team_id
          all_win_info << game_team[:game_id]
        end
      end
    all_win_info

    season_won = []
    @data.games.each do |game|
      all_win_info.each do |per_game|
      if per_game == game[:game_id]
        season_won << game[:season]
        end
      end
    end
      season_won
  end
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  def opponent_name(search_team_id)
    all_games_won = []
    @data.game_teams.each do |game_team|
      if game_team[:result] == "WIN" && game_team[:team_id] == search_team_id
        all_games_won << game_team[:game_id]
      end
    end
    all_games_won

    losing_teams = []
    @data.game_teams.each do |each_team|
      all_games_won.each do |game_won|
        if game_won == each_team[:game_id] && each_team[:result] == "LOSS"
          losing_teams << each_team[:team_id]
      end
    end
  end
    sorted_losing_teams = losing_teams.tally.sort_by do |key, value|
    value
    end
  end

  def goals_scored(search_team_id)
    highest_goals_scored = []
      @data.game_teams.each do |game_team|
      if game_team[:team_id] == search_team_id
        highest_goals_scored << game_team[:goals]
        end
      end
      highest_goals_scored
  end
end
