

class GameTeam
  attr_reader(
    :game_id,
    :team_id,
    :HoA,
    :result,
    :settled_in,
    :head_coach,
    :goals,
    :shots,
    :tackles,
    :pim,
    :powerPlayOpportunities,
    :powerPlayGoals,
    :faceOffWinPercentage,
    :giveaways,
    :takeaways
  )

  def initialize(row)
    @game_id = row[0]
    @team_id = row[1]
    @HoA = row[2]
    @result = row[3]
    @settled_in = row[4]
    @head_coach = row[5]
    @goals = row[6].to_i
    @shots = row[7].to_i
    @tackles = row[8].to_i
    @pim = row[9].to_i
    @powerPlayOpportunities = row[10].to_i
    @powerPlayGoals = row[11].to_i
    @faceOffWinPercentage = row[12].to_f
    @giveaways = row[13].to_i
    @takeaways = row[14].to_i
  end

  def num_games_played
    #amount of times team id shows up in data
  end

  def average_goals_overall
    # goals / number of games played
  end

  def average_goals_HoA
    # if HoA == away
    #   those games / number of games played
    # elsif HoA == home
    #   those games / number of games played
    # end
  end
end
