require './lib/stat_tracker'
class TeamsData < StatTracker

  attr_reader :teamData, :gameData
  def initialize(current_stat_tracker)
    @teamData = current_stat_tracker.teams
    @gameData = current_stat_tracker.games
    @gameTeamData = current_stat_tracker.game_teams

  end

  def team_info(team_id)
    selected_team = @teamData.select do |csv_row|
        csv_row["team_id"] == inp_team_id.to_s
      end

      team_hash = {
        team_id: selected_team[0]["team_id"].to_i,
        franchiseId: selected_team[0]["franchiseId"].to_i,
        teamName: selected_team[0]["teamName"],
        abbreviation: selected_team[0]["abbreviation"],
        link: selected_team[0]["link"]
      }

      team_hash

  end


  def all_games_by_team(team_id)
    games = @gameData.select do |row|
      row['home_team_id'] == team_id.to_s || row['away_team_id'] == team_id.to_s
    end
    games
  end

  def best_season(team_id)
    team_games = all_games_by_team(team_id)

    seasons = @gameData.map do |row|
      row['season']
    end.uniq

    season_games = Hash[seasons.collect { |item| [item, team_games.select { |game| item == game['season']}] } ]

  end


  def worst_season(team_id)

  end

  def average_win_percentage(team_id)
    selected_team_games = @gameTeamData.select do |csv_row|
      csv_row["team_id"] == team_id.to_s
    end
    total_won = []
    total_lost = []

    selected_team_games.each do |game|
      if game["result"] == "WIN"
        total_won << game
      elsif game["result"] == "LOSS"
        total_lost << game
      end
    end
    average_win_percentage = ((total_won.size / (total_won.size + total_lost.size).to_f) * 100).round(2)

    average_win_percentage
  end

  def most_goals_scored(team_id)
    selected_team_games = @gameTeamData.select do |csv_row|
      csv_row["team_id"] == team_id.to_s
    end

    highest_score = 0

    selected_team_games.each do |game|
      if game["goals"].to_i > highest_score
        highest_score = game["goals"].to_i
      end

    end
    highest_score
  end

  def fewest_goals_scored(team_id)
    selected_team_games = @gameTeamData.select do |csv_row|
      csv_row["team_id"] == team_id.to_s
    end

    lowest_score = 100

    selected_team_games.each do |game|
      if game["goals"].to_i < lowest_score
        lowest_score = game["goals"].to_i
      end

    end
    lowest_score
  end

  def convert_team_id_to_name(team_id_integer)
    name_array = []
    @team_data.each do |row|
      if row['team_id'].to_i == team_id_integer
        name_array << row['teamName']
      end
    end
    name_array[0]
  end

  def get_opponent_ids(team_games, team_id)
    opponent_ids = []
    team_games.each do |row|
      if row['home_team_id'] == team_id.to_s
        opponent_ids << row['away_team_id']
      end
      if row['away_team_id'] == team_id.to_s
        opponent_ids << row['home_team_id']
      end
    end
    opponent_ids = opponent_ids.uniq
  end

  def get_face_offs(team1_id, team2_id)
    team1_games = all_games_by_team(team1_id)
    face_offs = team1_games.select do |row|
      row['home_team_id'] == team2_id.to_s || row['away_team_id'] == team2_id.to_s
    end
    face_offs
  end

  def favorite_opponent(team_id)

    # get all games team has played in
    team_games = all_games_by_team(team_id)

    opponent_ids = get_opponent_ids(team_games, team_id)
    require 'pry'; binding.pry

    games_by_team = Hash.new

    # games_by_teams = Hash[opponent_ids.collect { |item| [item, team_games.select { |game| item == game['season']}] } ]

    # teams_games.each
    # if row['home_team_id'] == team_id.to_s
      # || opponent_ids << row['away_team_id']
    # break up games according to each unique team
    # find average_win_percentage of each teams total games
    # return lowest average
  end

  def rival(team_id)

  end
end
