require 'csv'
# require './runner.rb'
# require './data/games.csv'
# require './data/teams.csv'
# require './data/game_teams.csv'
class StatTracker
attr_reader :game_id
  def initialize
  end

  game_data = CSV.open"./data/games.csv",
  headers: true, header_converters: :symbol

  game = Array.new

  game_data.each do |row|
    game_id = row[:game_id]
    season = row[:season]
    type = row[:type]
    date_time = row[:date_time]
    away_team_id = row[:away_team_id]
    home_team_id = row[:home_team_id]
    away_goals = row[:away_goals]
    home_goals = row[:home_goals]
    venue = row[:venue]
    venue_link = row[:venue_link]

    game <<
  end
end

    game.each do |id|
      puts id.game_id
    end
    game_teams = Array.new

    game_teams_data.each do |row|
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
      power_play_opportunities = row[:powerplayopportunities]
      power_play_goals = row[:powerplaygoals]
      face_off_win_percentage = row[:faceoffwinpercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
    end

    teams = Array.new

    teams.each do |row|
      team_id = row[:team_id]
      franchise_id = row[:franchiseid]
      team_name = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
    end
