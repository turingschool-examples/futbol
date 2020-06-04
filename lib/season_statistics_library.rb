require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_teams_collection'

class SeasonStatisticsLibrary < StatisticsLibrary
  attr_reader :games,
              :teams,
              :game_teams

  def season_games(season)
    game_array = []
    @games.select do |game|
      game.season == season
      game_array << game
    end
    @game_id_array = game_array.map {|game| game.id}
  end

  def coach_games(game_array)
    coach_hash = Hash.new(0)
    @game_teams.each do |gameteam|
      @game_id_array.include?(gameteam.game_id)
        coach_hash[gameteam.head_coach] += 1
      end
    end
    coach_hash
  end

  def winningest_coach(season)
    season_game_array = season_games(season)
    win_percent = Hash.new(0)
    total_coach_games = coach_games(season_game_array)
    @game_teams.each do |gameteam|
          @game_id_array.include?(gameteam.game_id)
          if (gameteam.result == "WIN")
            logic = (1.to_f / (total_coach_games[gameteam.head_coach]))
            win_percent[gameteam.head_coach] += logic
          end
        end
      end
    coach_winner = win_percent.max_by do |key, value|
    win_percent[key]
    coach_winner.first
  end

  def worst_coach(season)
    win_loss = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          win_loss[gameteam.head_coach] ||= { win: 0, tot: 0, pct: 0 }
          win_loss[gameteam.head_coach][:tot] += 1
          if gameteam.result == "WIN"
            win_loss[gameteam.head_coach][:win] += 1
          end
          win_loss[gameteam.head_coach][:pct] = ((win_loss[gameteam.head_coach][:win] / win_loss[gameteam.head_coach][:tot].to_f) * 100).round(2)
        end
      return win_loss.min_by { |k, v| v[:pct]  }[0]
    end
  end

  def most_accurate_team(season)
    # most_accurate_team. Name of team w/ best ratio of shots to goals for the season	String
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= { shots: 0, goals: 0 }
          team_id_hash[gameteam.team_id][:shots] += gameteam.shots
          team_id_hash[gameteam.team_id][:goals] += gameteam.goals
        end
        team_id_hash.map do |k, v|
          team_id_hash[k] = ( v[:goals].to_f / v[:shots].to_f )
      end
      return @teams[(team_id_hash.max_by { |k, v| v }[0])].name
    end
  end

  def least_accurate_team(season)
    # most_accurate_team. Name of team w/ best ratio of shots to goals for the season	String
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= { shots: 0, goals: 0 }
          team_id_hash[gameteam.team_id][:shots] += gameteam.shots
          team_id_hash[gameteam.team_id][:goals] += gameteam.goals
        end
        team_id_hash.map do |k, v|
          team_id_hash[k] = ( v[:goals].to_f / v[:shots].to_f )
        end
      end
      return @teams[(team_id_hash.min_by { |k, v| v }[0])].name
    end

  def most_tackles(season)
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= gameteam.tackles
        end
        return @teams[(team_id_hash.max_by { |k, v| v }[0])].name
      end
    end


  def least_tackles(season)
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= gameteam.tackles
        end
        return @teams[(team_id_hash.min_by { |k, v| v }[0])].name
      end
    end
