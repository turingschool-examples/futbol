module Csv

  def csv_game_files
    if @locations[:games]
      CSV.foreach(@locations[:games], headers: true) do |row|
        @game_table[row["game_id"]] = Game.new(row)
      end
    end
  end

  def csv_team_files
    if @locations[:teams]
      CSV.foreach(@locations[:teams], headers: true) do |row|
        @team_table[row["team_id"]] = Team.new({team_id: row["team_id"],
                                       franchiseId: row["franchiseId"],
                                         team_name: row["teamName"],
                                      abbreviation: row["abbreviation"],
                                           stadium: row["stadium"],
                                              link: row["link"]})
      end
    end
  end

  def csv_game_team_files
    if @locations[:game_teams]
      CSV.foreach(@locations[:game_teams], headers: true) do |row|
        @game_team_table << GameTeam.new({game_id: row["game_id"],
                                                    team_id: row["team_id"],
                                                        hoa: row["hoa"],
                                                     result: row["result"],
                                                 settled_in: row["settled_in"],
                                                 head_coach: row["head_coach"],
                                                      goals: row["goals"],
                                                      shots: row["shots"],
                                                    tackles: row["tackles"],
                                                        pim: row["pim"],
                                     powerPlayOpportunities: row["powerPlayOpportunities"],
                                             powerPlayGoals: row["powerPlayGoals"],
                                       faceOffWinPercentage: row["faceOffWinPercentage"],
                                                  giveaways: row["giveaways"],
                                                  takeaways: row["takeaways"]})
      end
    end
  end

end
