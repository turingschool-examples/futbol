require 'csv'

class StatTracker

  attr_reader :data

  def initialize
    @data = []
    @games = [] #array of hashes
    @teams = [] #array of hashes
    @game_teams = [] #array of hashes

  end

  def self.from_csv(locations)
    stat_tracker = StatTracker.new
    i = 0

    locations.each_pair do |k, v|
      x = 0
      stat_tracker.data[i] = Hash.new
      CSV.foreach(v, headers: true) do |row|
          stat_tracker.data[i].store(v.to_s + x.to_s, row.to_hash)
          x += 1
      end

      i += 1
    end

    stat_tracker

  end

  #to access the values from these helper methods use this convention:
  #stat_tracker.access_by_id("game","2012030223")[0]["<row key>"]

  def access_by_id(file, id) #returns hash of games data for row by id

    if file == "game"
      index = 0
      key = "game_id"
    elsif file == "teams"
      index = 1
      key = "team_id"
    elseif file == "game_teams"
      index = 2
      key = "game_id"
    else
      return puts "Invalid file, id pair."
    end

    storage = @data[index].select do |k, v|
      v[key] == id
    end

    storage.values
  end

  #to access data
  #stat_tracker.teams = array of hashes of data from the file "teams"
  #stat_tracker.teams[key] = value

  def games
    @games = @data[0].values
  end

  def teams
    @teams = @data[1].values
  end

  def game_teams
    @game_teams = @data[2].values
  end

end
