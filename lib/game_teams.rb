class GameTeams
  @@instances = []

  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(game_id, team_id, hoa, result, head_coach, goals, shots, tackles)
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles

    @@instances << self
  end

  def self.from_csv(game_teams_path)
    CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
      self.new(
        row[:game_id],
        row[:team_id],
        row[:hoa],
        row[:result],
        row[:head_coach],
        row[:goals].to_i,
        row[:shots].to_i,
        row[:tackles].to_i
      )
    end
  end

  def self.all
    @@instances
  end

  # This method is for TESTING ONLY
  # Needed a way to reset @@instances between the tests as class
  # variables persist throughout a test run
  def self.reset
    @@instances.clear
  end
end