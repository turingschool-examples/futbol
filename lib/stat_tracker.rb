require 'csv'

class StatTracker

  attr_reader :game_path, :team_path, :game_teams_path

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_csv = CSV.read(@game_path, headers: true, header_converters: :symbol)
    @team_csv = CSV.read(@team_path, headers: true, header_converters: :symbol)
    @game_teams_csv = CSV.read(@game_teams_path, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def list_team_ids
    @team_csv.map { |row| row[:team_id] }
  end

  def list_team_names_by_id(id)
    @team_csv.each { |row| return row[:teamname] if id.to_s == row[:team_id] }           
  end

  def highest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.max
  end

  def lowest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.min
  end

  ########### SEASON METHODS ################

    def winningest_coach(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        coach_records[row[:head_coach]].push(row[:result])
      end
    end
    winning_percent = Hash.new
    coach_records.each do |coach, outcomes|
      # winning_percent[coach] = ((outcomes.count("WIN").to_f+0.5*outcomes.count("TIE"))/(outcomes.count))
      # ties don't count in spec_harness??
      winning_percent[coach] = ((outcomes.count("WIN").to_f)/(outcomes.count))
    end
    winning_percent.max_by { |_, percent| percent }.first
  end

  # this can be refactored alongside winningest_coach
  def worst_coach(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        coach_records[row[:head_coach]].push(row[:result])
      end
    end
    winning_percent = Hash.new
    coach_records.each do |coach, outcomes|
      # winning_percent[coach] = ((outcomes.count("WIN").to_f+0.5*outcomes.count("TIE"))/(outcomes.count))
      # ties don't count in spec_harness??
      winning_percent[coach] = ((outcomes.count("WIN").to_f)/(outcomes.count))
    end
    winning_percent.min_by { |_, percent| percent }.first
  end

  def most_accurate_team(season)
    team_goals = Hash.new { |team, goals| team[goals]=[] }
    team_shots = Hash.new { |team, shots| team[shots]=[] }
    team_accuracy = Hash.new
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f)
        team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    goals_sum = team_goals.transform_values(&:sum)
    shot_sum = team_shots.transform_values(&:sum)
    team_accuracy = goals_sum.merge(shot_sum) { |team, goals, shots | goals/shots }
    teamid = team_accuracy.max_by { |_, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end

  def least_accurate_team(season)
    team_goals = Hash.new { |team, goals| team[goals]=[] }
    team_shots = Hash.new { |team, shots| team[shots]=[] }
    team_accuracy = Hash.new
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f)
        team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    goals_sum = team_goals.transform_values(&:sum)
    shot_sum = team_shots.transform_values(&:sum)
    team_accuracy = goals_sum.merge(shot_sum) { |team, goals, shots | goals/shots }
    teamid = team_accuracy.min_by { |_, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end 

  def most_tackles(season)
    tackle_records = Hash.new(0)
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        tackle_records[row[:team_id]] += row[:tackles].to_i
      end
    end
    teamid = tackle_records.max_by { |_, tackles| tackles }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end

  def fewest_tackles(season)
    tackle_records = Hash.new(0)
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        tackle_records[row[:team_id]] += row[:tackles].to_i
      end
    end
    teamid = tackle_records.min_by { |_, tackles| tackles }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end

    ########### SEASON METHODS ################
end