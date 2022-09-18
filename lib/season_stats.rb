require 'initiable'

class SeasonStats
  include Initiable

  def self.from_csv_paths(file_paths)
    files = {
    game_csv: CSV.read(file_paths[:game_csv], headers: true, header_converters: :symbol),
    gameteam_csv: CSV.read(file_paths[:gameteam_csv], headers: true, header_converters: :symbol),
    team_csv:CSV.read(file_paths[:team_csv], headers: true, header_converters: :symbol)
    }
    SeasonStats.new(files)
  end

  def self.winningest_coach(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @@all_game_teams.each { |row| coach_records[row[:head_coach]].push(row[:result]) if row[:game_id].start_with?(season[0..3]) }
    winning_percent = Hash.new
    coach_records.each { |coach, outcomes| winning_percent[coach] = ((outcomes.count("WIN").to_f)/(outcomes.count)) }
    winning_percent.max_by { |_, percent| percent }.first
  end

  def self.worst_coach(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @@all_game_teams.each { |row| coach_records[row[:head_coach]].push(row[:result]) if row[:game_id].start_with?(season[0..3]) }
    winning_percent = Hash.new
    coach_records.each { |coach, outcomes| winning_percent[coach] = ((outcomes.count("WIN").to_f)/(outcomes.count)) }
    winning_percent.min_by { |_, percent| percent }.first
  end

  def self.most_accurate_team(season)
    team_goals = Hash.new { |team, goals| team[goals] = [] }
    team_shots = Hash.new { |team, shots| team[shots] = [] }
    @@all_game_teams.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f) && team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    goals_sum = team_goals.transform_values(&:sum)
    shot_sum = team_shots.transform_values(&:sum)
    team_accuracy = goals_sum.merge(shot_sum) { |_, goals, shots | goals / shots }
    teamid = team_accuracy.max_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.least_accurate_team(season)
    team_goals = Hash.new { |team, goals| team[goals] = [] }
    team_shots = Hash.new { |team, shots| team[shots] = [] }
    @@all_game_teams.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f)
        team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    goals_sum = team_goals.transform_values(&:sum)
    shot_sum = team_shots.transform_values(&:sum)
    team_accuracy = goals_sum.merge(shot_sum) { |_, goals, shots | goals/shots }
    teamid = team_accuracy.min_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.most_tackles(season)
    tackle_records = Hash.new(0)
    @@all_game_teams.each { |row| tackle_records[row[:team_id]] += row[:tackles].to_i if row[:game_id].start_with?(season[0..3]) }
    teamid = tackle_records.max_by { |_, tackles| tackles }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.fewest_tackles(season)
    tackle_records = Hash.new(0)
    @@all_game_teams.each { |row| tackle_records[row[:team_id]] += row[:tackles].to_i if row[:game_id].start_with?(season[0..3]) }
    teamid = tackle_records.min_by { |_, tackles| tackles }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end
end
