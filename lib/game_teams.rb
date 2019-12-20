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
    @@team = Team.from_csv("./test/fixtures/teams.csv")
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
        result[team_result[0]] = team_result[1].count {|game| game.result == 'WIN'}
        result
    end
    winningest_team_id = wins_per_team.max_by { |team| team[1] }[0]
    @@team.find {|team| team.team_id == winningest_team_id}.teamName
  end

  def best_fans
    #games_per_team = @@all.group_by {|game| game.team_id}
    
    # sort the game by teams
    # sort the team game into away
    # count how many games are won in away / divide by total number of games
    # sort the team game into home
    # count how many games are won in home / divide by total number of games
    # get the difference between the percentages
  end

end
