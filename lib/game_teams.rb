require 'csv'

class GameTeams
  
  @@all = []

  def self.all
    @@all
  end

   def self.team
    @@team
  end

  #this can be a self.reset method which makes an empty array again
  ## Teardown method for minitest

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all = csv.map do |row|
      GameTeams.new(row)
    end
    @@team = Team.from_csv("./data/teams.csv")
    # @@team = Team.from_csv("./test/fixtures/teams.csv")
  end

  attr_reader :game_id, :team_id, :hoa, :result, :goals

  def initialize(game_team_info)

    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:hoa]
    @result = game_team_info[:result]
    @goals = game_team_info[:goals]
  end

  def self.winningest_team
    games_per_team = @@all.group_by {|game| game.team_id}
    wins_per_team = games_per_team.reduce({}) do |result, team_result|
        result[team_result[0]] = team_result[1].count {|game| game.result == 'WIN'} / team_result[1].size.to_f
        result
    end
    winningest_team_id = wins_per_team.max_by { |team| team[1] }[0]
    @@team.find {|team| team.team_id == winningest_team_id}.teamName
  end

  def self.best_fans
    games_per_team = @@all.group_by {|game| game.team_id}
    home_away_games_per_team = games_per_team.reduce({}) do |result, games|
      result[games[0]] = games[1].group_by {|game| game.hoa}
      result
    end
    win_loss_perc_per_team = home_away_games_per_team.reduce({}) do |output, team|
      output[team[0]] = {
        away_win_percentage: ((team[1]["away"].count {|game| game.result == "WIN"})/team[1]["away"].size.to_f).round(2), 
        home_win_percentage: ((team[1]["home"].count {|game| game.result == "WIN"})/team[1]["home"].size.to_f).round(2)
        }
      output
    end
    temp = win_loss_perc_per_team.reduce({}) do |result, team|
      result[team[0]] = [team[1][:home_win_percentage] - team[1][:away_win_percentage] , 0].max
      result
    end
    best_fan_team_id = (temp.max_by {|team| team[1]})[0]
    @@team.find {|team| team.team_id == best_fan_team_id}.teamName
  end

   def self.worst_fans
    games_per_team = @@all.group_by {|game| game.team_id}
    home_away_games_per_team = games_per_team.reduce({}) do |result, games|
      result[games[0]] = games[1].group_by {|game| game.hoa}
      result
    end
    win_loss_perc_per_team = home_away_games_per_team.reduce({}) do |output, team|
      output[team[0]] = {
        away_win_percentage: ((team[1]["away"].count {|game| game.result == "WIN"})/team[1]["away"].size.to_f).round(4), 
        home_win_percentage: ((team[1]["home"].count {|game| game.result == "WIN"})/team[1]["home"].size.to_f).round(4)
        }
      output
    end
    worst_fan_team_id = win_loss_perc_per_team.map do |team|
      team[1][:away_win_percentage] > team[1][:home_win_percentage] ? team[0] : nil
    end.compact #[0]
    worst_fan_team_id.map do |team_id|
      @@team.find {|team| team.team_id == team_id}.teamName
    end
  end

end
