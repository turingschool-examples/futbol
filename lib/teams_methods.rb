module Teams_Methods

  def team_info(team_name)

    team_info = {}
    team = @teams.select do |team|
      team.teamName == team_name
    end
    team = team[0]
    team_info['team_id'] = team.team_id
    team_info['franchiseId'] = team.franchiseId
    team_info['teamName'] = team.teamName
    team_info['abbreviation'] = team.abbreviation
    team_info['link'] = team.link

    team_info
  end

  def average_win_percentage(team_id)

    wins = 0
    loss_or_tie = 0
    rows = []

    @game_teams.each do |row|
      if row.team_id == team_id
        rows << row
      end
    end

    rows.each do |row|
      if row.result == 'WIN'
        wins += 1
      elsif row.result != 'WIN'
        loss_or_tie += 1
      end
    end

    wins = wins.to_f
    loss_or_tie = loss_or_tie.to_f
    total = wins + loss_or_tie
    percentage = (wins / total) * 100
    percentage = percentage.round(2)
    percentage
  end


end
