require_relative './teams'
require_relative './game'
require_relative './game_teams'


class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = Game.create_multiple_games(locations[:games])
    teams = Teams.create_multiple_teams(locations[:teams])
    game_teams = GameTeams.create_multiple_game_teams(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    high_low_added = @games.map do |game|
      [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    high_low_added.max
  end

  def team_info(team_id)
    team_hash = Hash.new(0)
    @teams.each do |team|
      if team_id == team.team_id
        team_hash["team_id"] = team.team_id
        team_hash["franchise_id"] = team.franchise_id
        team_hash["team_name"] = team.team_name
        team_hash["abbreviation"] = team.abbreviation
        team_hash["link"] = team.link
      end
    end
    team_hash
  end

  # def most_goals_scored(team_id)  #use game_teams, iterate thru game_teams and find the max
  #   @game_teams.map do |game|
  #     if team_id == game.team_id

  #       game.goals.to_i
  #       require 'pry';binding.pry
  #       end
  #     end
  #   end

  def most_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      if team_id == game.team_id
        goals_by_game << game.goals.to_i
      end
    end
    goals_by_game.max
  end

  def fewest_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      if team_id == game.team_id
        goals_by_game << game.goals.to_i
      end
    end
    goals_by_game.min
  end


  def lowest_total_score
    high_low_added = @games.map do |game|
      [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    high_low_added.min
  end

  def percentage_home_wins
    numerator = @games.find_all {|game| game.home_goals.to_i > game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def percentage_visitor_wins
    numerator = @games.find_all {|game| game.home_goals.to_i < game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def percentage_ties
    numerator = @games.find_all {|game| game.home_goals.to_i == game.away_goals.to_i }.size
    denominator = games.size
    (numerator.to_f/denominator).round(2)
  end

  def count_of_games_by_season
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def average_goals_per_game
    total_goals_per_game = []
       @games.map do |game|
        total_goals_per_game << [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    ((total_goals_per_game.sum.to_f)/(@games.size)).round(2)
  end

  def winningest_coach(season_id)

    coaches = {}
    game_id_list = []
    @games.each do |game|

      if game.season == season_id
          game_id_list << game.game_id
        end
    end
    coaches = Hash.new(0)

    @game_teams.each do |game_team|
      game_id = game_team.game_id
      coach = game_team.head_coach
      if !game_id_list.include?game_id
        next
      end

        if game_team.result == "WIN"
            coaches[coach]+=1
          end
        end

      coach_percentage_won =
      coaches.map do |coach_name, game_win|
        percentage_won = (game_win.to_f/game_id_list.length) * 100
        [coach_name, percentage_won]
      end.to_h

      winningest_coach= coach_percentage_won.max {|coach_average_1, coach_average_2| coach_average_1[1]<=>coach_average_2[1]}
      winningest_coach[0]
    end
  end

  def worst_coach(season_id)

    coaches = {}
    game_id_list = []
    @games.each do |game|
      if game.season == season_id
          game_id_list << game.game_id

      end
    end
    coaches = Hash.new(0)

    @game_teams.each do |game_team|
      game_id = game_team.game_id
      coach = game_team.head_coach
      if !game_id_list.include?game_id
        next
      end

        if game_team.result == "LOSS"
            coaches[coach]+=1
        end
      end

      coach_percentage_lost =
      coaches.map do |coach_name, game_loss|
        percentage_lost = (game_loss.to_f/game_id_list.length) * 100
        [coach_name, percentage_lost]
      end.to_h
      worst_coach= coach_percentage_lost.min {|coach_average_1, coach_average_2| coach_average_1[1]<=>coach_average_2[1]}
      worst_coach[0]
    
  end
