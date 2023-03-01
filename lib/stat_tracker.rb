require 'csv'

class StatTracker
  attr_reader :games,
              :game_teams,
              :teams
              
  def initialize
    @games = []
    @game_teams = []
    @teams = []
  end

  def from_csv
    games = CSV.open './data/games.csv', headers: true, header_converters: :symbol
    games.each do |row|
      id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away = row[:away_team_id]
      home = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(id, season, type, date_time, away, home, away_goals, home_goals, venue, venue_link)
    end

    game_teams = CSV.open './data/game_teams.csv', headers: true, header_converters: :symbol
    game_teams.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      powerplayopportunities = row[:powerplayopportunities]
      powerplaygoals = row[:powerplayGoals]
      faceoffwinpercentage = row[:faceoffwinpercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      @game_teams << GameTeam.new(game_id, team_id, hoa, result, settled_in, head_coach,goals, shots, tackles, pim, powerplayopportunities, powerplaygoals, faceoffwinpercentage, giveaways, takeaways)
    end

    teams = CSV.open './data/teams.csv', headers: true, header_converters: :symbol
    teams.each do |row|
      team_id = row[:team_id]
      franchiseid = row[:franchiseid]
      teamname = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id, franchiseid, teamname, abbreviation, stadium, link)
    end
  end
end