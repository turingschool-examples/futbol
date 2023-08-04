require './lib/stat_daddy'
require "csv"
require "pry"

class SeasonStats < StatDaddy

  # kind of pseudo coded out this stuff
  # @games.season.sort(season)
  #   season 12 = @games.season("20122013")
  #   season 13 = @games.season("20132014")
  #   season 14 = @games.season("20142015")
  #   season 15 = @games.season("20152016")
  #   season 16 = @games.season("20162017")
  #   season 17 = @games.season("20172018")

  def winningest_coach()
    # percentage_home_wins
    # percentage_visitor_wins
    # percentage_ties

  #   @games.team_id.each do |data|
  #     loss = data.result("loss")
  #     win = data.result("win")
  #     tie = data.result("tie")

  #     # lost + win + tie and then the percentage somehow

  #   home_win_percentage = (home_wins.to_f / total_games) * 100
  #   home_win_percentage.round(2)
  # end

   
  end

    # Name of the Coach with the worst win percentage for the season
  end

  def most_accurate_team()
    # Name of the Team with the best ratio of shots to goals for the season
  end

  def least_accurate_team()
    # Name of the Team with the worst ratio of shots to goals for the season
  end

  def most_tackles
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

  def fewest_tackles()
    @games_teams_fixture_path.each do |data|
      # Name of the Team with the fewest tackles in the season
    end
  end
end
