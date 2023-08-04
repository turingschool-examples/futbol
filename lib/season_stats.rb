require "./lib/stat_daddy"
require "csv"
require "pry"

class SeasonStats < StatDaddy
  def winningest_coach(season)
    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)

    @game_teams.each do |game_team|
      game = @games.find { |game| game.game_id == game_team.game_id }
      next if game.nil? || game.season != season

      coach = game_team.head_coach
      coach_wins[coach] += 1 if game_team.result == "WIN"
      coach_games[coach] += 1
    end

    coach_win_percentages = {}
    coach_wins.each do |coach, wins|
      total_games = coach_games[coach]
      win_percentage = (wins.to_f / total_games) * 100
      coach_win_percentages[coach] = win_percentage.round(2)
    end
  end

  def worst_coach(season)
  end

  def most_accurate_team(season)
    # Name of the Team with the best ratio of shots to goals for the season
  end

  def least_accurate_team(season)
    # Name of the Team with the worst ratio of shots to goals for the season
  end

  def most_tackles(season)
    team_tackles = []
    # Name of the Team with the most tackles in the season
    @games_teams_fixture_path.each do |data|
      @team_id = data.team_id.to_i
      @tackles = data.tackles.to_i
      # team_tackles[@team_id] += @tackles
      @team_goals.each do |team_id, tackles|
        puts "Team ID #{team_id}: Total Tackles - #{tackles}"
      end
      tackles
    end
  end

  def fewest_tackles(season)
    @games_teams_fixture_path.each do |data|
      # Name of the Team with the fewest tackles in the season
    end
  end
end
