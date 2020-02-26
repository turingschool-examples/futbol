class Team
  @@teams = {}

  def self.add(team)
    @@teams[team.team_id] = team
  end

  def self.all
    @@teams
  end

  def self.teams=(value)
    @@teams = value
  end

  def self.return_team_name(team_id)
    @@teams.find do |_game_id, team|
      if team.team_id == team_id
        return team.team_name
      end
    end
  end

  def self.performance_ranking(group = nil)
  rankings = Team.all.values.minmax_by do |team|
    games_with_team = Game.games_played_by_team(team)
    if !games_with_team.empty?
      total_score = games_with_team.sum do |game|
      if group == :defense
        game.home_team_id == team.team_id ? game.away_goals : game.home_goals
      else
        game.home_team_id == team.team_id ? game.home_goals : game.away_goals
      end
    end
      total_score.to_f / games_with_team.count
    end
  end
  {highest: rankings.last.team_name, lowest: rankings.first.team_name}
  end

  def self.home_or_away_ranking(field = nil)
    rankings = Team.all.values.minmax_by do |team|
      games = Game.all.values.select do |game|
      if field == :home
        game.home_team_id == team.team_id
      else
        game.away_team_id == team.team_id
      end
    end

      total_score = games.sum do |game|
        field == :home ? game.home_goals : game.away_goals
      end 
      total_score.to_f / games.count
    end
    {highest: rankings.last.team_name, lowest: rankings.first.team_name}
  end


  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @team_name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

end
