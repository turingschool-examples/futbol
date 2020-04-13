require 'csv'

class Team

  @@all = nil

  def self.all
    @@all
  end

  def self.find_team_info(id)
    id = id.to_i
    selected_team = @@all.find{|team| team.team_id==id}
    team_info = {}
    team_info["abbreviation"]= selected_team.abbreviation
    team_info["franchise_id"]= selected_team.franchise_id.to_s
    team_info["link"]= selected_team.link
    team_info["team_id"]= selected_team.team_id.to_s
    team_info["team_name"]= selected_team.team_name
    team_info
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map do |row|
      Team.new(row)
    end
  end

<<<<<<< HEAD
  attr_reader :game_teams, :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link
=======
  def self.count_of_teams
    all.length
  end

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link, :team_name
>>>>>>> master

  def initialize(team_info)
    @game_teams = game_teams
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:team_name]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
    @team_name = team_info[:teamname]
  end
end
