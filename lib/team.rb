class Team
  extend CsvLoadable

  attr_reader :team_id, :team_name

  @@all_teams = []

  def self.all
    @@all_teams
  end

  def self.from_csv(file_path)
    @@all_teams = load_from_csv(file_path, Team)
  end

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
  end

  








end
