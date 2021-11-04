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


  def parse_seasons
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
    win_percentages_by_season = Hash.new
    # create a new Hash
      # keys are season
      # values are percentage of wins

    # remove all irrelevent data from separated_seasons values

    sanitized_hash = separated_seasons.map do |season, value|

      value.each do |row|
        require 'pry'; binding.pry
        if row['home_team_id'] != team_id.to_s && row['away_team_id'] != team_id.to_s
          value.delete(row)
        end
      end
    end


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
