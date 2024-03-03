require 'CSV'

class GameTeam
  @@game_teams = []
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(gameteam_data)
    @game_id = gameteam_data[:game_id]
    @team_id = gameteam_data[:team_id]
    @hoa = gameteam_data[:hoa]
    @result = gameteam_data[:result]
    @head_coach = gameteam_data[:head_coach]
    @goals = gameteam_data[:goals]
    @shots = gameteam_data[:shots]
    @tackles = gameteam_data[:tackles]
  end

  def self.create_from_csv(game_teams_path)
    CSV.foreach(game_teams_path, headers: true, converters: :all) do |row|
      gameteam_data = { 
        game_id: row["game_id"],
        team_id: row["team_id"],
        hoa: row["HoA"],
        result: row["result"],
        settled_in: row["settled_in"],
        head_coach: row["head_coach"],
        goals: row["goals"],
        shots: row["shots"],
        tackles: row["tackles"]
      }
    @@game_teams << GameTeam.new(gameteam_data)
    end
    @@game_teams
  end

  def self.game_teams
    @@game_teams
  end

  def self.avg_scores_per_team_home
    team_scores = Hash.new(0)
    gameteam_counter = Hash.new(0)
    @@game_teams.each do |gameteam|
      if gameteam.hoa == "home"
        team_scores[gameteam.team_id] += gameteam.goals
        gameteam_counter[gameteam.team_id] += 1
      end
    end
    z = []
    result_hash = {}
    team_scores.values.each_with_index do |value, index|
      z << (value.to_f / gameteam_counter.values[index])
    end
    result_hash = team_scores.keys.zip(z).to_h
  end
end