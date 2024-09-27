require "csv"
require './lib/game'
require './lib/team'
require './lib/game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @games = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    @games_array = []
    # fill_game_array
    # fill_team_array
    # fill_game_teams_array
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end



  def fill_team_array
    @teams.each do |row|
      team_id = row[:team_id]
      franchise_id = row[:franchise_id]
      team_name = row[:team_name]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      teams_array << Team.new(team_id, franchise_id, team_name,
         abbreviation, stadium, link)
      end
  end

  def fill_game_teams_array
    @game_teams.each do |row|
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
      power_play_opportunities = row[:power_play_opportunities]
      power_play_goals = row[:power_play_goals]
      face_off_win_percentage = row[:face_off_win_percentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      game_teams_array << GameTeams.new(game_id, team_id, hoa, result, settled_in, head_coach, goals,
        shots, tackles, pim, power_play_opportunities, power_play_goals,
        face_off_win_percentage, giveaways, takeaways)
      end
  end

  def load_collections
    @game_stats = GameStats.new(locations[:game_stats])
    #this does stuff so other classes can use it :D
  end




  end
