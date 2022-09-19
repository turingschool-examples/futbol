require 'initiable'

class SeasonStats < CSV_loader

  def self.from_csv_paths(file_paths)
    files = {
    game_csv: CSV.read(file_paths[:game_csv], headers: true, header_converters: :symbol),
    gameteam_csv: CSV.read(file_paths[:gameteam_csv], headers: true, header_converters: :symbol),
    team_csv:CSV.read(file_paths[:team_csv], headers: true, header_converters: :symbol)
    }
    SeasonStats.new(files)
  end  

  def season_id(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @all_game_teams.each { |row| coach_records[row[:head_coach]].push(row[:result]) if row[:game_id].start_with?(season[0..3]) }
    coach_records.map { |coach, outcomes| [coach, outcomes = ((outcomes.count("WIN").to_f)/(outcomes.count))] }
   end

  def team_accuracy(season)
    team_goals = Hash.new { |team, goals| team[goals] = [] }
    team_shots = Hash.new { |team, shots| team[shots] = [] }
    @all_game_teams.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f) && team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    team_goals.transform_values(&:sum).merge(team_shots.transform_values(&:sum)) { |team, goals, shots | goals / shots }
  end

  def winningest_coach(season)
    season_id(season).max_by { |_, percent| percent }.first
  end

  def worst_coach(season)
    season_id(season).min_by { |_, percent| percent }.first
  end  

  def most_accurate_team(season)
    teamid = team_accuracy(season).max_by { |_, percent| percent }.first
    @all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def least_accurate_team(season)
    teamid = team_accuracy(season).min_by { |_, percent| percent }.first
    @all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def most_tackles(season)
    tackle_records = Hash.new(0)
    @all_game_teams.each { |row| tackle_records[row[:team_id]] += row[:tackles].to_i if row[:game_id].start_with?(season[0..3]) }
    teamid = tackle_records.max_by { |_, tackles| tackles }.first
    @all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def fewest_tackles(season)
    tackle_records = Hash.new(0)
    @all_game_teams.each { |row| tackle_records[row[:team_id]] += row[:tackles].to_i if row[:game_id].start_with?(season[0..3]) }
    teamid = tackle_records.min_by { |_, tackles| tackles }.first
    @all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end
end