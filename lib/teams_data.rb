require './lib/stat_tracker'
class TeamsData < StatTracker

  attr_reader :teamData
  def initialize(current_stat_tracker)
    @teamData = current_stat_tracker.teams
    @gameData = current_stat_tracker.games
    #

  end

  def team_info(team_id)
    @team_id = @teams["team_id"]
    @franchise_id = @teams["franchise_id"]
    @team_name = @teams["teamName"]
    @abbreviation = @teams["abbreviation"]
    @link = @teams["link"]


  end


  def parse_seasons(team_id=nil)
    seasons = @gameData.map do |row|
      row['season']
    end.uniq

    parsed_seasons = Hash[seasons.collect { |item| [item, []] } ]

    parsed_seasons.each do |season|
      @gameData.each do |row|
        if season[0] == row['season']
          season[1] << row
        end
      end
    end

    parsed_seasons
  end

  def best_season(team_id)
    separated_seasons = parse_seasons
    team_games_by_season = Hash[separated_seasons.keys.collect { |item| [item, nil] } ]

    separated_seasons.each do |key, value|
      filtered_season_stats = []

      value.each do |row|
        if row['home_team_id'] == team_id.to_s || row['away_team_id'] == team_id.to_s
          filtered_season_stats << row
        end
      end

      team_games_by_season[key] = filtered_season_stats
    end

    team_games_by_season.each do |key, season|
      win_count = 0

      season.each do |row|
        home_win = row['home_goals'].to_i > row['away_goals'].to_i
        away_win = row['home_goals'].to_i < row['away_goals'].to_i
        if team_id == row['home_team_id'].to_i && home_win
          win_count += 1
        elsif team_id == row['away_team_id'].to_i && away_win
          win_count += 1
        end
      end
      team_games_by_season[key] = ((win_count/season.count) * 100).round(2)
    end
    # require 'pry'; binding.pry
    team_games_by_season.key(team_games_by_season.values.max)

  end


  def worst_season(team_id)

  end

  def average_win_percentage(team_id)

  end

  def most_goals_scored(team_id)

  end

  def fewest_goals_scored(team_id)

  end

  def favorite_opponent(team_id)

  end

  def rival(team_id)

  end
end
