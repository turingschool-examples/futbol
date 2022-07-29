module Seasonable
  def games_by_season(season)
    games_array = []
    @games_data.each do |row|
    games_array <<row[:game_id] if row[:season] == season
    end
    games_array
  end

  def coaches_by_season(season)
    coaches_array = []
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        coaches_array << row[:head_coach].to_sym if game == row[:game_id]
      end
    end
    coaches_array.uniq
  end

  def coach_records(season)
    coach_records = Hash.new
    coaches_by_season(season).each do |coach|
      coach_records.store(coach, {wins: 0, total_games: 0})
    end
    coach_records
  end

  def populate_coach_records(season, records)
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        process_coach_record(records, row) if game == row[:game_id]
      end
    end
  end

  def process_coach_record(records, row)
    if row[:result] == "WIN"
      records[row[:head_coach].to_sym][:wins] += 1
      records[row[:head_coach].to_sym][:total_games] += 1
    else
      records[row[:head_coach].to_sym][:total_games] += 1
    end
  end

  def winning_record(records)
    records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
  end

  def accuracy_records(season)
    team_accuracy_record = {}
    teams_by_season(season).each do |team|
      team_accuracy_record[team.to_sym] = {shots: 0, goals: 0}
    end
    team_accuracy_record
  end

  def populate_accuracy_records(season, records)
    @game_teams_data.each do |row|
      games_by_season(season).each do |game|
        process_accuracy_record(records, row) if game == row[:game_id]
      end
    end
  end

  def process_accuracy_record(records, row)
    records[row[:team_id].to_sym][:goals] += row[:goals].to_i
    records[row[:team_id].to_sym][:shots] += row[:shots].to_i
  end

  def most_accurate(records)
    records.max_by { |h,k| (k[:goals].to_f / k[:shots].to_f) }[0]
  end

  def least_accurate(records)
    records.min_by { |h,k| (k[:goals].to_f / k[:shots].to_f) }[0]
  end

  def tackle_records(season)
    team_tackles_record = {}
    teams_by_season(season).each do |team|
      team_tackles_record[team.to_sym] = 0
    end
    team_tackles_record
  end

  def populate_tackle_records(season, records)
    @game_teams_data.each do |row|
      games_by_season(season).each do |game|
        process_tackle_record(records, row) if game == row[:game_id]
      end
    end
  end

  def process_tackle_record(records, row)
    records[row[:team_id].to_sym] += row[:tackles].to_i
  end

  def best_tackling_team(records)
    records.max_by { |team, tackles| tackles }[0]
  end

  def worst_tackling_team(records)
    records.min_by { |team, tackles| tackles }[0]
  end

  def teams_by_season(season)
    teams_array = []
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        if game == row[:game_id]
          teams_array << row[:team_id].to_sym
        end
      end
    end
    teams_array.uniq
  end
end