require "csv"

class StatTracker
  
  def self.from_csv(locations)
    game_hash = {}
    stat_tracker = StatTracker.new
    
    game_hash[:games] = stat_tracker.game_generator(locations)
    game_hash[:teams] = stat_tracker.teams_generator(locations)
    game_hash[:game_teams] = stat_tracker.game_teams_generator(locations)
    game_hash
  end
  
  # helper methods
  
  def game_generator(locations)
    games =[]
    CSV.foreach locations[:games], headers: true, header_converters: :symbol do |row|
      games << Game.new(row[:game_id], row[:season], row[:type], row[:date_time], row[:away_team_id], row[:home_team_id], row[:away_goals], row[:home_goals], row[:venue])
    end
    games
  end
  
  def teams_generator(locations)
    teams = []
    CSV.foreach locations[:teams], headers: true, header_converters: :symbol do |row|
      teams << Team.new(row[:team_id], row[:franchiseid], row[:teamname], row[:abbreviation], row[:stadium])
    end
    teams
  end
  
  def game_teams_generator(locations)
    game_teams =[]
    CSV.foreach locations[:game_teams], headers: true, header_converters: :symbol do |row|
      game_teams << GameTeam.new(row[:game_id], row[:team_id], row[:hoa], row[:result], row[:settled_in], row[:head_coach], row[:goals], row[:shots], row[:tackles], row[:pim], row[:powerplayopportunities], row[:powerplaygoals], row[:faceoffwinpercentage], row[:giveaways], row[:takeaways])
    end
    game_teams
  end
  
end
