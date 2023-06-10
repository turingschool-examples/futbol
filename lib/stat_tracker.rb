require "csv"

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = create_games(locations[:games])
    @teams = create_teams(locations[:teams])
    @game_teams = create_game_teams(locations[:game_teams])
  end

  # Helper methods for initialization
  def read_csv(file_path)
    CSV.parse(File.read(file_path), headers: true, header_converters: :symbol)
  end

  def create_games(file_path) 
    data = read_csv(file_path)
    games = []
    data.each do |row|
      games << Game.new(
        row[:game_id],
        row[:season], 
        row[:type], 
        row[:date_time], 
        row[:away_team_id], 
        row[:home_team_id],
        row[:away_goals],
        row[:home_goals],
        row[:venue],
        row[:venue_link]
      )
    end
    games
  end

  def create_teams(file_path) 
    data = read_csv(file_path)
    teams = []
    data.each do |row|
      teams << Team.new(
        row[:team_id], 
        row[:franchiseid], 
        row[:teamname], 
        row[:abbreviation], 
        row[:stadium], 
        row[:link]
      )
    end
    teams
  end

  def create_game_teams(file_path)
    data = read_csv(file_path)
    game_teams = []
    data.each do |row|
      game_teams << GameTeam.new(
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
        row[:takeaways]
      )
    end
    game_teams
  end

  def count_of_teams
    @teams.count
  end

  # Season Stats

  def most_tackles(season)
    team_tackles = Hash.new(0)
  
    relevant_game_teams = @game_teams.select { |game_team| @games.find { |game| game.game_id == game_team.game_id }.season == season }
  
    relevant_game_teams.each do |game_team|
      team_tackles[game_team.team_id] += game_team.tackles.to_i
    end
  
    team_id_with_most_tackles = team_tackles.max_by { |_team_id, tackles| tackles }[0]
    team = @teams.find { |team| team.team_id == team_id_with_most_tackles }
    team.team_name
  end

end