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

  # def self.best_offense
    #games.each do |game|
    # if totals.has_key?(game.team_id)
    #   totals[game.team_id] << game.goals
    # else
    #   totals[game.team_id] = [game.goals]

    # rankings = {}
    # @@game_teams.each do |gts| #gameteam stat
    #   (rankings[gts.team_id] ||= [])
      # set values inside the array(key value).
    # end
    # Team has names.
    # For each in the array,
    # if the team id is not in hash,
    # add as a new key, add its goals,
    # and increment the games counter.
    # @@game_teams.goals
    # require 'pry'; binding.pry
    # divide goals scored by number of games played for each team
    # return team id(/name) with highest average score
  # end

  # def self.worst_offense
  #   Name of the team with the lowest average number of goals scored per game across all seasons.
  # end

end
