require 'csv'

class Team

  @@all = nil

  def self.all
    @@all
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map do |row|
      Team.new(row)
    end
  end

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end

#Michelle start
  def find_team_names(team_id)
    match_team = @@all.find do |team|
      team.team_id == team_id
    end
    match_team.team_name
  end


  def all_teams_playing
    @game_teams.map {|game_team| game_team.team_id}.uniq
  end





#   def most_tackles(season_id)
#   team_id = all_teams_playing.max_by do |team|
#     tackles_per_team_in_season(team, season_id)
#   end
#   find_team_names(team_id)
# end
#
# def fewest_tackles(season_id)
#   array = []
#   all_teams_playing.each do |team|
#     if tackles_per_team_in_season(team, season_id) != 0
#       array << team
#     end
#   end
#   team_id = array.min_by do |team|
#     tackles_per_team_in_season(team, season_id)
#   end
#   find_team_names(team_id)
# end
#Michelle end
end
