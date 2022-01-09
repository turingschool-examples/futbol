require 'csv'

class TeamStatistics
  attr_reader :stat_files

   def initialize(stat_files)
     @stat_files = stat_files
     @teams_file= CSV.readlines stat_files[:teams], headers: true, header_converters: :symbol
     @games_file = stat_files[:games]
     @games_by_team = stat_files[:game_stats]
   end

   def team_info
     # team_id, franchise_id, team_name, abbreviation, and link.
    team_info = {}
    @teams_file.each do |row|
      team_info[:team_id] = row[:team_id]
      team_info[:franchiseid] = row[:franchiseid]
      team_info[:teamname] = row[:teamname]
      team_info[:abbreviation] = row[:abbreviation]
      team_info[:link] = row[:link]
    end
    team_info
   end
end
