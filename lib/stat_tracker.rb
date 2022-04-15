require "csv"
require './lib/game'
require './lib/team'
require './lib/game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams, :games_array

  def initialize(locations)
    @game_data = CSV.read(locations[:games], headers:true,
       header_converters: :symbol)
    @team_data = CSV.read(locations[:teams], headers:true,
       header_converters: :symbol)
    @game_team_data = CSV.read(locations[:game_teams],
       headers:true, header_converters: :symbol)
    # @games_array = []
    @games = Game.fill_game_array(@game_data)
    @teams = Team.fill_team_array(@team_data)
    @game_teams = GameTeams.fill_game_teams_array(@game_team_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score(game_data)
    sum = 0
    highest_sum = 0
    game_data.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      #require 'pry'; binding.pry
      highest_sum = sum if sum > highest_sum
    end
    highest_sum
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

  def count_of_teams

  end


  end
