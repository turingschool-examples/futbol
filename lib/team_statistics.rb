require_relative "./lib/league_collection"

class TeamStatistics

  def team_info(team_id)
    return_hash = {}
    teams.each do |team|
      if team.team_id == team_id.to_s
        return_hash = team.to_hash
      end
    end
    return_hash
  end

  def game_teams_array(team_id)
    game_teams.select do |game_team|
      game_team.team_id == team_id.to_s
    end
  end

  def games_array(team_id)
    games.select do |game|
      game.home_team_id == team_id.to_s || game.away_team_id == team_id.to_s
    end
  end

  def combine_arrays(team_id)
    combined_array = []
    games_array(team_id).each do |game|
      game_teams_array(team_id).each do |game_team|
          combined_array << [game_team.game_id, game_team.result, game.season] if game_team.game_id == game.game_id
      end
    end
    combined_array
  end

  def find_seasons(team_id)
    win_hash = Hash.new(0)
    loss_hash = Hash.new(0)
    tie_hash = Hash.new(0)
    combine_arrays(team_id).each do |array|
      win_hash[array[2]] += 1 if array[1] == "WIN"
      loss_hash[array[2]] += 1 if array[1] == "LOSS"
      tie_hash[array[2]] += 1 if array[1] == "TIE"
    end
    win_hash = win_hash.sort.to_h
    loss_hash = loss_hash.sort.to_h
    tie_hash = tie_hash.sort.to_h
    win_hash_values = win_hash.values
    loss_hash_values = loss_hash.values
    tie_hash_values = tie_hash.values
    team_season = []
    win_hash.size.times do |x|
      team_season[x] = ((win_hash_values[x]).to_f / (win_hash_values[x] +
        loss_hash_values[x] + tie_hash_values[x]))
    end
    [win_hash, team_season]
  end

  def best_season(team_id)
    find_seasons(team_id)[0].to_a[find_seasons(team_id)[1].index(find_seasons(team_id)[1].max)][0]
  end

  def worst_season(team_id)
    find_seasons(team_id)[0].to_a[find_seasons(team_id)[1].index(find_seasons(team_id)[1].min)][0]
  end

  def average_win_percentage(team_id)
    total = find_seasons(team_id)[1].inject(:+)
    len = find_seasons(team_id)[1].length
    average = (total.to_f / len).round(2)
  end

  def most_goals_scored(team_id)
    game_teams_array(team_id).max_by do |game|
      game.goals
    end.goals.to_i
  end

  def fewest_goals_scored(team_id)
    game_teams_array(team_id).min_by do |game|
      game.goals
    end.goals.to_i
  end

  def find_team_by_id(team_id)
    teams.find {|team| team.team_id == team_id}
  end

  def games_played_by_team(team_id)
    game_teams.find_all {|game| game.team_id == team_id.to_s}
  end

  def games_by_opponent_team(team_id)
    x = games_played_by_team(team_id).group_by{|game| game.game_id}
    games = game_teams.select do |game|
       key = x.keys
       key.include?(game.game_id) && !x.values.flatten.include?(game)
    end
    games.group_by{|game| game.team_id}
  end

  def opponent_percentage_wins(team_id)
    games_by_opponent_team(team_id).transform_values do |games|
      wins = games.select{|game| game.result == "WIN"}.length
      (wins / games.size.to_f * 100).round(2)
    end
  end

  def favorite_opponent(team_id)
    id =opponent_percentage_wins(team_id).min_by{|k,v| v}.first
    find_team_by_id(id).team_name
  end

  def rival(team_id)
    id =opponent_percentage_wins(team_id).max_by{|k,v| v}.first
    find_team_by_id(id).team_name
  end

end
