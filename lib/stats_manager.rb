require 'csv'

class  StatsManager
attr_reader :stats
  def initialize 
    @stats = { 
      games: [], 
      teams: [], 
      game_teams:[] 
    }
  end

  def stat_organizer(file_path, type) 
    data = CSV.parse(File.read(file_path), headers: true, header_converters: :symbol)
    data.each do |row|
      if type == :games 
        create_games(type, row)
      elsif type == :teams
        create_teams(type, row)
      elsif type == :game_teams
        create_game_teams(type, row)
      end
    end
  end

  # potential refactor to create game and shovel in within stat_organizer method (SRP)

  def create_games(type, row) 
    @stats[type] << Game.new(
      row[:game_id],
      row[:season], 
      row[:type], 
      row[:date_time], 
      row[:away_team_id], 
      row[:home_team_id],
      row[:away_goals],
      row[:home_goals],
      row[:venue],
      row[:venue_link])
  end

  # potential refactor to create teams and shovel in within stat_organizer method (SRP)

  def create_teams(type, row) 
    @stats[type] << Team.new(
      row[:team_id], 
      row[:franchiseid], 
      row[:teamname], 
      row[:abbreviation], 
      row[:stadium], 
      row[:link])
  end

  # potential refactor to create game_teams and shovel in within stat_organizer method (SRP)

  def create_game_teams(type, row)
    @stats[type] << GameTeam.new(
      row[:game_id], 
      row[:team_id], 
      row[:hoa], 
      row[:result], 
      row[:settled_in], 
      row[:head_coach], 
      row[:goals], 
      row[:shots], 
      row[:tackles], 
      row[:pim], 
      row[:powerplayopportunities], 
      row[:powerplaygoals], 
      row[:faceoffwinpercentage], 
      row[:giveaways], 
      row[:takeaways])
  end
end

# x = StatsManager.new
# x.stat_organizer("./data/teams.csv", :teams)



  # def get_attrs(row) 
  #   x = row.to_h.keys
  #   x.each do |y|
  #     require 'pry'; binding.pry
      
  #   end
  # end
  
  # @stats[type] << Game.new(*get_attrs(row))