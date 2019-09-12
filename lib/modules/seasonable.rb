module Seasonable


  def biggest_bust(season_id)
    team_summaries = {}
    seasons[season_id].teams.values.each do |team|
      team_summaries[team] = team.summary
    end
    busted_team = team_summaries.max_by do |team, summary| 
      summary[:regular_season][:win_percentage] - summary[:postseason][:win_percentage]
    end
    busted_team.first.name
  end

  def biggest_surprise(season_id)
    team_summaries = {}
    seasons[season_id].teams.values.each do |team|
      team_summaries[team] = team.summary
    end
    busted_team = team_summaries.min_by do |team, summary| 
      summary[:regular_season][:win_percentage] - summary[:postseason][:win_percentage]
    end
    busted_team.first.name
  end

  def winningest_coach(season_id)
    coach_summaries = {}

    seasons[season_id].teams.values.each do |team|
      team.games.values.each do |game|
        coach = team.coach(game)
        if !coach_summaries.has_key?(coach)
          coach_summaries[coach] = {
            games_won: team.win?(game) ? 1 : 0,
            games_played: 1
          }
        else
          coach_summaries[coach][:games_won]    += team.win?(game) ? 1 : 0
          coach_summaries[coach][:games_played] += 1
        end
      end
    end
    coach_summaries
      .max_by { |coach, summary| summary[:games_won] / summary[:games_played].to_f }
      .first
  end

  def worst_coach(season_id)
    coach_summaries = {}

    seasons[season_id].teams.values.each do |team|
      team.games.values.each do |game|
        coach = team.coach(game)
        if !coach_summaries.has_key?(coach)
          coach_summaries[coach] = {
            games_won: team.win?(game) ? 1 : 0,
            games_played: 1
          }
        else
          coach_summaries[coach][:games_won]    += team.win?(game) ? 1 : 0
          coach_summaries[coach][:games_played] += 1
        end
      end
    end
    coach_summaries
      .min_by { |coach, summary| summary[:games_won] / summary[:games_played].to_f }
      .first
  end

  def most_accurate_team(season_id)
    team_accuracies = {}
    seasons[season_id].teams.values.each do |team|
      shots_taken = 0
      goals_scored = 0
      team.games.values.each do |game|
        shots_taken += team.shots_taken(game)
        goals_scored += team.goals_scored(game)
      end
      team_accuracies[team] = goals_scored / shots_taken.to_f
    end
    team_accuracies
      .max_by { |team, accuracy| accuracy }
      .first
      .name
  end

  def least_accurate_team(season_id)
    team_accuracies = {}
    seasons[season_id].teams.values.each do |team|
      shots_taken = 0
      goals_scored = 0
      team.games.values.each do |game|
        shots_taken += team.shots_taken(game)
        goals_scored += team.goals_scored(game)
      end
      team_accuracies[team] = goals_scored / shots_taken.to_f
    end
    team_accuracies
      .min_by { |team, accuracy| accuracy }
      .first
      .name
  end

  def most_tackles(season_id)
    team_tackles = {}
    seasons[season_id].teams.values.each do |team|
      team_tackles[team] = team.games.values.sum { |game| team.tackles_made(game) }
    end
    team_tackles
      .max_by { |team, tackles| tackles }
      .first
      .name
  end

  def fewest_tackles(season_id)
    team_tackles = {}
    seasons[season_id].teams.values.each do |team|
      team_tackles[team] = team.games.values.sum { |game| team.tackles_made(game) }
    end
    team_tackles
      .min_by { |team, tackles| tackles }
      .first
      .name
  end 
end
