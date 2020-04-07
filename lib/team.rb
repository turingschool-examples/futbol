require 'csv'

class Team

  @@all = []

  def self.create_teams(csv_file_path)
    csv = CSV.read(csv_file_path, headers: true, header_converters: :symbol)

    all_teams = csv.map do |row|
      Team.new(row)
    end

    @@all = all_teams
  end

  def self.all
    @@all
  end

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link


  def initialize(team_parameter)
    @team_id = team_parameter[:team_id].to_i
    @franchise_id = team_parameter[:franchiseid].to_i
    @team_name = team_parameter[:teamname]
    @abbreviation = team_parameter[:abbreviation]
    @stadium = team_parameter[:stadium]
    @link = team_parameter[:link]
  end
end
