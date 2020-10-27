class TeamStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def team_info_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['franchiseId'], @stat_tracker[:teams]['teamName'], @stat_tracker[:teams]['abbreviation'], @stat_tracker[:teams]['link'])
  end

  def find_team_id(team_id)
    team_info_data_set.map do |item|
      return item if item[0] == team_id
    end
  end

  def team_info(team_id)
    team_data = {}
    headers = [:team_id, :franchise_id, :team_name, :abbreviation, :link]
    headers.each_with_index do |header, index|
      team_data[header] = find_team_id(team_id)[index]
    end
    team_data
  end

  def game_teams_data_set
    @stat_tracker[:game_teams]['game_id'].zip(@stat_tracker[:game_teams]['team_id'], @stat_tracker[:game_teams]['result'], @stat_tracker[:game_teams]['goals'])
  end

  def winning_games(team_id)
    game_teams_data_set.select do |game|
      team_id == game[1] && game[2] == 'WIN'
    end
  end

  def losing_games(team_id)
    game_teams_data_set.select do |game|
      team_id == game[1] && game[2] == 'LOSS' || game[2] == 'TIE'
    end
  end

  def total_games(team_id)
    game_teams_data_set.select do |game|
      team_id == game[1]
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

  def losses_by_game_id(team_id)
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
    losses_by_season
    end
  end

  def winning_games_by_game_id(team_id)
    wins_by_season = Hash.new {|hash_obj, key| hash_obj[key] = 0}
    winning_games(team_id).map do |season|
      if season[0].start_with?('2012')
        wins_by_season['20122013'] += [season[2]].count
      elsif season[0].start_with?('2013')
        wins_by_season['20132014'] += [season[2]].count
      elsif season[0].start_with?('2014')
        wins_by_season['20142015'] += [season[2]].count
      elsif season[0].start_with?('2015')
        wins_by_season['20152016'] += [season[2]].count
      elsif season[0].start_with?('2016')
        wins_by_season['20162017'] += [season[2]].count
      elsif season[0].start_with?('2017')
        wins_by_season['20172018'] += [season[2]].count
      end
    end
    wins_by_season
  end

  def best_season(team_id)
    win_percentage = Hash.new {|hash_obj, key| hash_obj[key] = []}
    winning_games_by_game_id(team_id).each do |season, num_wins|
      total_games_by_game_id(team_id).each do |seazon, total|
        if season == seazon
          win_percentage[season] << (num_wins / total).round(2)
        end
      end
    end
    win_percentage.max_by {|season, pct| pct}[0]
  end
end
