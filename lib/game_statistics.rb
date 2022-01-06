require 'csv'

class GameStatistics
  attr_reader :files

  def initialize(files)
    @files = files
    @games_file = CSV.readlines files[:games], headers: true, header_converters: :symbol
    @teams_file= files[:teams]
    @games_by_team = CSV.readlines files[:game_stats], headers: true, header_converters: :symbol
  end

  def highest_total_score
    scores = @games_file.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    hts = scores.max
    index_array = []
    scores.each_with_index do |score,index|
      index_array << index if score == hts
    end
    # @games_file.each_with_index do |row, index|
    #   index_array.select do |score_index|
    #     puts "#{row} #{hts}" if score_index == index
    #   end
    # end
    hts
  end

  def lowest_total_score
    scores = @games_file.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    lts = scores.min
    index_array = []
    scores.each_with_index do |score,index|
      index_array << index if score == lts
    end
    # @games_file.each_with_index do |row, index|
    #   index_array.select do |score_index|
    #     puts "#{row} #{lts}" if score_index == index
    #   end
    # end
      lts
  end

  def percentage_home_wins
    home_wins = 0
    @games_by_team.each do |row|
      home_wins +=1 if row[:hoa] == "home" && row[:result] == "WIN"
    end
    perc_home_wins = home_wins.to_f / @games_by_team.size
    perc_home_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @games_by_team.each do |row|
      visitor_wins +=1 if row[:hoa] == "away" && row[:result] == "WIN"
    end
    perc_visitor_wins = visitor_wins.to_f / @games_by_team.size
    perc_visitor_wins.round(2)
  end

  def percentage_ties
    num_ties = 0
    @games_by_team.each do |row|
      num_ties +=1 if row[:result] == "TIE"
    end
    perc_tie = num_ties.to_f / @games_by_team.size
    perc_tie.round(2)
  end

  def count_of_games_by_season
    season_array = @games_file.map do |row|
      row[:season]
    end
    season_array.group_by { |season| season }.transform_values { |values| values.count }
  end

  def average_goals_per_game
    num_goals = 0
    @games_file.each do |row|
      num_goals += row[:away_goals].to_i + row[:home_goals].to_i
    end
    avg_goals = num_goals.to_f / @games_file.size
    avg_goals.round(2)
  end

end
