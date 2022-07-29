class SeasonStats

  def initialize(data)
    @data = data
  end

  def winningest_coach
    coach_win_percentage.max_by{|coach, percentage| percentage}.first
  end

  def worst_coach(target_season)
    coach_win_percentage.max_by{|coach, percentage| -percentage}.first
  end

  def most_accurate_team(target_season)
    team_id_highest_accuracy = team_id_accuracy.max_by{|team, acc| acc}.first
    id_team_key[team_id_highest_accuracy]

  end

  def least_accurate_team(target_season)
    games = @games.select do |game|
              game[:season] == target_season
            end

    game_ids = games.map do |game|
                game[:game_id]
               end

    game_teams = @game_teams.select do |game|
                    game_ids.include?(game[:game_id])
                  end

    goals = Hash.new(0)
    shots = Hash.new(0)
    game_teams.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end

    team_id_lowest_accuracy = team_id_accuracy.max_by{|team, acc| -acc}.first

    id_team_key = @teams[:team_id].zip(@teams[:teamname]).to_h

    id_team_key[team_id_lowest_accuracy]
  end

  private

  def id_team_key(key)
    @teams[:team_id].zip(@teams[:teamname]).to_h

  def team_id_accuracy
    goals = Hash.new(0)
    shots = Hash.new(0)
    @data.each do |game|
      goals[game[:team_id]] += game[:goals].to_f
      shots[game[:team_id]] += game[:shots].to_f
    end

    team_id_accuracy = Hash.new
    goals.each do |team, goals|
      team_id_accuracy[team] = goals / shots[team]
    end
  end

  def coach_win_percentage
    coaches_and_results= @data.map do |game|
                            [game[:result], game[:head_coach]]
                          end

    wins = Hash.new(0)
    all_games = Hash.new(0)

    coaches_and_results.each do |result, coach|
      wins[coach] += 1 if result == "WIN"
      all_games[coach] += 1
    end

    win_percentage = Hash.new
    wins.map do |coach, num_wins|
      win_percentage[coach] = num_wins.to_f / all_games[coach]
    end
    win_percentage
  end

end
