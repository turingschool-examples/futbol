module Listable
  def games_by_season(season_id, csv_table)
    csv_table.find_all do |game|
      game.game_id.to_s[0..3] == season_id[0..3]
    end
  end

  def info_by_season(season, type)
    if type == :head_coach
      season.map {|game| game.head_coach}.uniq
    elsif type == :team_id
      season.map {|game| game.team_id}.uniq
    elsif type == :team_tackles
      teams_tackles = {}
      season.each do |game|
        if teams_tackles.any?{teams_tackles[game.team_id]} == false
          teams_tackles[game.team_id] = game.tackles
        else
          teams_tackles[game.team_id] += game.tackles
        end
      end
      teams_tackles
    elsif type == :team_shots
      teams_shots = {}
      season.each do |game|
        if teams_shots.any?{teams_shots[game.team_id]} == false
          teams_shots[game.team_id] = game.shots
        else
          teams_shots[game.team_id] += game.shots
        end
      end
      teams_shots
    elsif type == :team_goals
      teams_goals = {}
      season.each do |game|
        if teams_goals.any?{teams_goals[game.team_id]} == false
          teams_goals[game.team_id] = game.goals
        else
          teams_goals[game.team_id] += game.goals
        end
      end
      teams_goals
    elsif type == :team_wins
      teams_wins = {}
      season.each do |game|
        if teams_wins.any?{teams_wins[game.team_id]} == false && game.result == "WIN"
          teams_wins[game.team_id] = 1
        elsif game.result == "WIN"
          teams_wins[game.team_id] += 1
        end
      end
      require "pry";binding.pry
      teams_wins
    end
  end
end
