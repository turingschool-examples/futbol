module Teamable

  def team_info(team_id)
   {
      "team_id" => teams[team_id].id,
      "team_name" => teams[team_id].name,
      "franchise_id" => teams[team_id].franchise_id,
      "abbreviation" => teams[team_id].abbreviation,
      "link" => teams[team_id].link
    }
  end

  def best_season(team_id)
    seasons
      .values
      .max_by {|season| season.teams[team_id].total_wins / season.teams[team_id].games.length.to_f}
      .id
  end

  def worst_season(team_id)
    seasons
      .values
      .min_by {|season| season.teams[team_id].total_wins / season.teams[team_id].games.length.to_f}
      .id
  end
  
  def average_win_percentage(team_id)

  end

  def most_goals_scored(team_id)

  end

  def fewest_goals_scored(team_id)

  end

  def favorite_opponent(team_id)

  end

  def rival(team_id)

  end

  def biggest_team_blowout(team_id)

  end

  def worst_loss(team_id)

  end

  def head_to_head(team_id)

  end

  def seasonal_summary(team_id)

  end
end
