module SeasonMethods

  def all_coaches
    coaches_array = []
    @game_teams.each do |row|
      if coaches_array.include?(row.head_coach) == false
        coaches_array << row.head_coach
      end
    end
    coaches_array
  end

  def winningest_coach

    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)

    @game_teams.each do |row|
      if row.result == "LOSS"
        coach_losses[row.head_coach] = coach_losses[row.head_coach] + 1
      elsif row.result == "WIN"
        coach_wins[row.head_coach] = coach_wins[row.head_coach] + 1
      end
    end

    coach_total_games = Hash.new(0)
    coach_win_percentage = Hash.new(0)

    coach_wins.each do |name, wins|
      coach_total_games[name] = coach_losses[name] + coach_wins[name]
      coach_win_percentage[name] = coach_wins[name]/coach_total_games[name].to_f
    end

    # consider how i want to do this
    return coach_win_percentage.max_by{|name, percentage| percentage}
  end

  def worst_coach

    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)

    @game_teams.each do |row|
      if row.result == "LOSS"
        coach_losses[row.head_coach] = coach_losses[row.head_coach] + 1
      elsif row.result == "WIN"
        coach_wins[row.head_coach] = coach_wins[row.head_coach] + 1
      end
    end

    coach_total_games = Hash.new(0)
    coach_win_percentage = Hash.new(0)

    coach_wins.each do |name, wins|
      coach_total_games[name] = coach_losses[name] + coach_wins[name]
      coach_win_percentage[name] = coach_wins[name]/coach_total_games[name].to_f
    end

    # require "pry"; binding.pry
    # consider how i want to do this
    return coach_win_percentage.min_by{|k,v| v}

  end

  def most_tackles
    team_tackles = Hash.new(0)

  end

end
