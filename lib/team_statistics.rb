class TeamStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  # Data Sets
  def team_info_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['franchiseId'], @stat_tracker[:teams]['teamName'], @stat_tracker[:teams]['abbreviation'], @stat_tracker[:teams]['link'])
  end

  def game_teams_data_set
    @stat_tracker[:game_teams]['game_id'].zip(@stat_tracker[:game_teams]['team_id'], @stat_tracker[:game_teams]['result'], @stat_tracker[:game_teams]['goals'])
  end

  # Team Statistics Methods
  # def team_info(team_id)
  #   team_data = {}
  #   headers = [:team_id, :franchise_id, :team_name, :abbreviation, :link]
  #   headers.each_with_index do |header, index|
  #     team_data[header] = team_info_row(team_id)[index]
  #   end
  #   team_data
  # end

  # def best_season(team_id)
  #   win_percentage = Hash.new {|hash_obj, key| hash_obj[key] = []}
  #   winning_games_by_game_id(team_id).each do |season, num_wins|
  #     total_games_by_game_id(team_id).each do |seazon, total|
  #       if season == seazon
  #         win_percentage[season] << (num_wins / total).round(2)
  #       end
  #     end
  #   end
  #   win_percentage.max_by {|season, pct| pct}[0]
  # end

  def worst_season(team_id)
    loss_percentage = Hash.new {|hash_obj, key| hash_obj[key] = []}
    losing_games_by_game_id(team_id).each do |season, num_lost|
      total_games_by_game_id(team_id).each do |seazon, total|
        if season == seazon
          loss_percentage[season] << (num_lost / total).round(2)
        end
      end
    end
    loss_percentage.min_by {|season, pct| pct}[0]
  end

  def average_win_percentage(team_id)
    (winning_games(team_id).count / total_games(team_id).count.to_f * 100).round(2)
  end

  def most_goals_scored(team_id)
    game_teams_data_set.select do |id|
      team_id == id[1]
    end.max_by {|score| score[3]}[3].to_i
  end

  def fewest_goals_scored(team_id)
    game_teams_data_set.select do |id|
      team_id == id[1]
    end.min_by {|score| score[3]}[3].to_i
  end

  def favorite_oponent(team_id)
    team_info(lowest_win_percentage(team_id))[:team_name]
  end

  def rival(team_id)
    team_info(highest_win_percentage(team_id))[:team_name]
  end

  # Helper Methods
  def team_info_row(team_id)
    team_info_data_set.map do |item|
      return item if item[0] == team_id
    end
  end

  def total_games(team_id)
    game_teams_data_set.select do |game|
      team_id == game[1] && game[2] != 'TIE'
    end
  end

  def winning_games(team_id)
    game_teams_data_set.select do |game|
      team_id == game[1] && game[2] == 'WIN'
    end
  end

  def losing_games(team_id)
    game_teams_data_set.select do |game|
      team_id == game[1] && game[2] == 'LOSS'
    end
  end

  def total_games_by_game_id(team_id)
    total_by_season = Hash.new {|hash_obj, key| hash_obj[key] = 0}
    total_games(team_id).map do |season|
      if season[0].start_with?('2012')
        total_by_season['20122013'] += [season[2]].count.to_f
      elsif season[0].start_with?('2013')
        total_by_season['20132014'] += [season[2]].count.to_f
      elsif season[0].start_with?('2014')
        total_by_season['20142015'] += [season[2]].count.to_f
      elsif season[0].start_with?('2015')
        total_by_season['20152016'] += [season[2]].count.to_f
      elsif season[0].start_with?('2016')
        total_by_season['20162017'] += [season[2]].count.to_f
      elsif season[0].start_with?('2017')
        total_by_season['20172018'] += [season[2]].count.to_f
      end
    end
    total_by_season
  end

  # def winning_games_by_game_id(team_id)
  #   wins_by_season = Hash.new {|hash_obj, key| hash_obj[key] = 0}
  #   winning_games(team_id).map do |season|
  #     if season[0].start_with?('2012')
  #       wins_by_season['20122013'] += [season[2]].count
  #     elsif season[0].start_with?('2013')
  #       wins_by_season['20132014'] += [season[2]].count
  #     elsif season[0].start_with?('2014')
  #       wins_by_season['20142015'] += [season[2]].count
  #     elsif season[0].start_with?('2015')
  #       wins_by_season['20152016'] += [season[2]].count
  #     elsif season[0].start_with?('2016')
  #       wins_by_season['20162017'] += [season[2]].count
  #     elsif season[0].start_with?('2017')
  #       wins_by_season['20172018'] += [season[2]].count
  #     end
  #   end
  #   wins_by_season
  # end

  def losing_games_by_game_id(team_id)
    losses_by_season = Hash.new {|hash_obj, key| hash_obj[key] = 0}
    losing_games(team_id).map do |season|
      if season[0].start_with?('2012')
        losses_by_season['20122013'] += [season[2]].count
      elsif season[0].start_with?('2013')
        losses_by_season['20132014'] += [season[2]].count
      elsif season[0].start_with?('2014')
        losses_by_season['20142015'] += [season[2]].count
      elsif season[0].start_with?('2015')
        losses_by_season['20152016'] += [season[2]].count
      elsif season[0].start_with?('2016')
        losses_by_season['20162017'] += [season[2]].count
      elsif season[0].start_with?('2017')
        losses_by_season['20172018'] += [season[2]].count
      end
    end
    losses_by_season
  end

  def total_opposing_team_games(team_id)
    total_games = Hash.new {|hash_obj, key| hash_obj[key] = []}
    game_teams_data_set.select do |id|
      winning_games(team_id).map do |game_id|
        if id[0] == game_id[0]
          total_games[id[1]] << id[1] unless id[1] == team_id
        end
      end
    end
    total_games
  end

  def lowest_opposing_team(team_id)
    highest_opp_losses = Hash.new {|hash_obj, key| hash_obj[key] = 0}
    game_teams_data_set.select do |id|
      winning_games(team_id).map do |game_id|
        if id[0] == game_id[0]
          highest_opp_losses[id[1]] += 1 unless id[1] == team_id
        end
      end
    end
    highest_opp_losses
  end

  def lowest_win_percentage(team_id)
    highest_loser_pct = {}
    game_teams_data_set.select do |id|
      winning_games(team_id).map do |game_id|
        if id[0] == game_id[0]
          highest_loser_pct[id[1]] = (lowest_opposing_team(team_id)[id[1]]/ total_opposing_team_games(team_id)[id[1]].count.to_f * 100).round(2) unless id[1] == team_id
        end
      end
    end
    highest_loser_pct.max_by {|id, pct| pct}[0]
  end

  def highest_opposing_team(team_id)
    highest_opp_wins = Hash.new {|hash_obj, key| hash_obj[key] = 0}
    game_teams_data_set.select do |id|
      losing_games(team_id).map do |game_id|
        if id[0] == game_id[0]
          highest_opp_wins[id[1]] += 1 unless id[1] == team_id
        end
      end
    end
    highest_opp_wins
  end

  def highest_win_percentage(team_id)
    highest = {}
    game_teams_data_set.select do |id|
      winning_games(team_id).map do |game_id|
        if id[0] == game_id[0]
          highest[id[1]] = (highest_opposing_team(team_id)[id[1]]/ total_opposing_team_games(team_id)[id[1]].count.to_f * 100).round(2) unless id[1] == team_id
        end
      end
    end
    highest.max_by {|id, pct| pct}[0]
  end
end
