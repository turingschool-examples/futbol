class Game
  @@games = []
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link
      
              
  def initialize(attributes)
    @game_id = attributes[:game_id]
    @season = attributes[:season]
    @type = attributes[:type]
    @date_time = attributes[:date_type]
    @away_team_id = attributes[:away_team_id]
    @home_team_id = attributes[:home_team_id]
    @away_goals = attributes[:away_goals]
    @home_goals = attributes[:home_goals]
    @venue = attributes[:venue]
    @venue_link = attributes[:venue_link]
    @@games << self
  end

  def self.games
    @@games
  end

  # def seasons_games
  #   seasons = Game.games.group_by {|game| game.season}
  #   require 'pry'; binding.pry
  # end

  # def most_tackles(season)
  #   season_sorted = Game.games.group_by {|game| game.season}
  #   teams = GameTeam.gameteam.group_by {|team| team.team_id}
  #   team_tackles = Hash.new(0)
  #   teams.each do |team, data_array|
  #     count = 0  
  #     data_array.each do |data|
  #       if data.game_id == game_id
  #         count = data.tackles
  #       end
  #     end
  #     team_tackles[team] = count
  #   end
  #   team_tackles.max_by {|team, tackles| tackles}[0]
  # end
end