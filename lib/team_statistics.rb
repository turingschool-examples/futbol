require 'csv'

class TeamStatistics
  attr_reader :stat_files

   def initialize(stat_files)
     @stat_files = stat_files
     @teams_file = CSV.readlines stat_files[:teams], headers: true, header_converters: :symbol
     @games_file = CSV.readlines stat_files[:games], headers: true, header_converters: :symbol
     @games_by_team = CSV.readlines stat_files[:game_teams], headers: true, header_converters: :symbol
   end

   def team_info(team)
     # team_id, franchise_id, team_name, abbreviation, and link.
    team_info_hash = {}
    @teams_file.each do |row|
      if row[:team_id] = team
        team_info_hash[:team_id] = row[:team_id]
        team_info_hash[:franchiseid] = row[:franchiseid]
        team_info_hash[:teamname] = row[:teamname]
        team_info_hash[:abbreviation] = row[:abbreviation]
        team_info_hash[:link] = row[:link]
      end
    end
    team_info_hash
   end

   # def best_season
   #   home_wins    = 0
   #   away_wins    = 0
   #   home_losses  = 0
   #   away_losses  = 0
   #   home_ties    = 0
   #   away_ties    = 0
   #   total_wins   = home_wins + away_wins
   #   total_losses = home_losses + away_losses
   #   total_ties   = home_ties + away_ties
   #   total_games  = total_wins + total_losses + total_ties
   #   best_season  = []
   #   @games_by_team.each do |row|
   #     home_wins +=1 if [:hoa] == "home" && row[:result] == "WIN"
   #   end
   #   @games_by_team.each do |row|
   #     away_wins +=1 if [:hoa] == "away" && row[:result] == "WIN"
   #   end
   #   @games_by_team.each do |row|
   #     home_losses +=1 if [:hoa] == "home" && row[:result] == "LOSS"
   #   end
   #   @games_by_team.each do |row|
   #     away_losses +=1 if [:hoa] == "away" && row[:result] == "LOSS"
   #   end
   #   @games_by_team.each do |row|
   #     home_ties +=1 if [:hoa] == "home" && row[:result] == "TIE"
   #   end
   #   @games_by_team.each do |row|
   #     away_ties +=1 if [:hoa] == "away" && row[:result] == "TIE"
   #   end
     # result = team with best wins / losses
   end
end
