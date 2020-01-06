require_relative './calculateable'
require_relative './gatherable'

module SeasonStats
  include Calculateable
  include Gatherable

  def biggest_bust(season_id)
    regular = team_regular_season_record(season_id)
    post = team_postseason_record(season_id)
    require 'pry'; binding.pry
    biggest_difference = win_percentage_difference(regular, post)
    require 'pry'; binding.pry
    team_id = biggest_difference.max_by { |_k, v| v }[0]
    get_team_name_by_id(team_id)
  end

  def biggest_surprise(season_id)
    regular = team_regular_season_record(season_id)
    post = team_postseason_record(season_id)
    biggest_increase = win_percentage_increase(regular, post)
    team_id = biggest_increase.max_by { |_k, v| v }[0]
    get_team_name_by_id(team_id)
  end

  def total_season_games_team_id(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      hash[season.first] = season[1][season_id].size
      hash
    end
  end

  def team_season_record(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      team_id = season.first
      team_season = season[1][season_id].flatten
      hash[team_id] = win_lose_draw(season.first, team_season)
      team_season_win_percentage(hash, team_id)
      hash
    end
  end

  def team_season_win_percentage(hash, team_id)
    total_games = (hash[team_id][:win] + hash[team_id][:loss] + hash[team_id][:draw])
    wins = hash[team_id][:win]
    percentage = ((wins.to_f / total_games) * 100).round(2)
    hash[team_id][:win_percentage] = percentage
    hash
  end

  def win_lose_draw(team_id, team_season)
    record = { win: 0, loss: 0, draw: 0, regular_season_games: 0, postseason_games: 0, win_percentage: 0 }
    team_season.reduce({}) do |hash, game|
      if team_id == game.home_team_id && (game.home_goals > game.away_goals)
        record[:win] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif team_id == game.home_team_id && (game.home_goals < game.away_goals)
        record[:loss] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif team_id == game.away_team_id && (game.away_goals > game.home_goals)
        record[:win] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif team_id == game.away_team_id && (game.away_goals < game.home_goals)
        record[:loss] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif game.home_goals == game.away_goals
        record[:draw] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      end
      hash = record
      hash
    end
  end

  def team_regular_season_record(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      next(hash) if season[1][season_id].nil?

      team_id = season.first
      team_season = season[1][season_id].flatten
      hash[team_id] = win_lose_draw_regular_season(season.first, team_season)
      team_season_win_percentage(hash, team_id)
      hash
    end
  end

  def win_lose_draw_regular_season(team_id, team_season)
    record = { win: 0, loss: 0, draw: 0, regular_season_games: 0, win_percentage: 0 }
    team_season.reduce({}) do |hash, game|
      if team_id == game.home_team_id && (game.home_goals > game.away_goals) && game.type == 'Regular Season'
        record[:win] += 1
        record[:regular_season_games] += 1
      elsif team_id == game.home_team_id && (game.home_goals < game.away_goals) && game.type == 'Regular Season'
        record[:loss] += 1
        record[:regular_season_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals > game.home_goals) && game.type == 'Regular Season'
        record[:win] += 1
        record[:regular_season_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals < game.home_goals) && game.type == 'Regular Season'
        record[:loss] += 1
        record[:regular_season_games] += 1
      elsif game.home_goals == game.away_goals && game.type == 'Regular Season'
        record[:draw] += 1
        record[:regular_season_games] += 1
      end
      hash = record
      hash
    end
  end

  def team_postseason_record(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      next(hash) if season[1][season_id].nil?

      team_id = season.first
      team_season = season[1][season_id].flatten
      hash[team_id] = win_lose_draw_postseason(season.first, team_season)
      team_season_win_percentage(hash, team_id)
      hash
    end
  end

  def win_lose_draw_postseason(team_id, team_season)
    record = { win: 0, loss: 0, draw: 0, postseason_games: 0, win_percentage: 0 }
    team_season.reduce({}) do |hash, game|
      if team_id == game.home_team_id && (game.home_goals > game.away_goals) && game.type == 'Postseason'
        record[:win] += 1
        record[:postseason_games] += 1
      elsif team_id == game.home_team_id && (game.home_goals < game.away_goals) && game.type == 'Postseason'
        record[:loss] += 1
        record[:postseason_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals > game.home_goals) && game.type == 'Postseason'
        record[:win] += 1
        record[:postseason_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals < game.home_goals) && game.type == 'Postseason'
        record[:loss] += 1
        record[:postseason_games] += 1
      elsif game.home_goals == game.away_goals && game.type == 'Postseason'
        record[:draw] += 1
        record[:postseason_games] += 1
      end
      hash = record
      hash
    end
  end
end
