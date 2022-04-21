<<<<<<< HEAD
##tests that don't fucking work

describe 'Season Statistics' do

  it "organizes seasons by year" do

    expect(@stat_tracker.games_by_season("20122013").count).to eq(20)
    expect(@stat_tracker.games_by_season("20122013")).to be_a(Array)
  end

  it "organizes a specific season by team" do

    expect(@stat_tracker.organize_teams("20122013").count).to eq(30)
    expect(@stat_tracker.organize_teams("20122013").length).to eq(30)

  end

  xit "calculates the winning percentage per team per season" do

    expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["1"]).to eq(0.33)
    expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["10"]).to eq(0.44)
    expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["17"]).to eq(0.47)
    expect(@stat_tracker.team_winning_percentage_by_season("2012030221")["3"]).to eq(0.37)

  end

  xit "returns head coach given team_id" do

    expect(@stat_tracker.head_coach_name("3")).to eq(("John Tortorella"))

  end

  xit "returns winningest head coach" do

    expect(@stat_tracker.winningest_coach("2012030221")).to eq(("Claude Julien"))

  end

  xit "returns loser head coach" do

    expect(@stat_tracker.worst_coach("2012030221")).to eq(("Gerard Gallant"))

  end

  xit "returns calculates the shooting percentage per team per season" do


    expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["3"]).to eq(0.25)
    expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["8"]).to eq(0.29)
    expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["26"]).to eq(0.3)
    expect(@stat_tracker.team_shot_percentage_by_season("2012030221")["30"]).to eq(0.28)
  end

  xit "defines team name by team_id" do

    expect(@stat_tracker.team_name("3")).to eq(("Houston Dynamo"))
  end

  xit "returns most accurate team" do


    expect(@stat_tracker.most_accurate_team("20122013")).to eq(("DC United"))
  end

  xit "returns least accurate team" do

    expect(@stat_tracker.least_accurate_team("20122013")).to eq(("Houston Dynamo"))

  end

  xit "returns the total number of tackles per team in a season" do

    expect(@stat_tracker.total_tackles_by_season("20122013")).to be_a(Hash)

  end

  xit "returns the team with the most tackles" do

    expect(@stat_tracker.most_tackles("2012030221")).to be_a(String)
  end

  xit "returns the team with the least amount of tackles" do

    expect(@stat_tracker.fewest_tackles("2012030221")).to be_a(String)
  end
end
=======
class SeasonStats

# Team Statistics
    def team_info(team_id)
        team_hash = {}
        @teams.each do |team|
        # require 'pry'; binding.pry
        if team.team_id == team_id
            team_hash = {
            "team_id" => team.team_id,
            "franchise_id" => team.franchise_id,
            "team_name" => team.team_name,
            "abbreviation" => team.abbreviation,
            "link" => team.link
            }
        end
        end
        team_hash
    end

    def season_games(game_id)
        season = ""
        @games.find do |game|
        if game_id[0..3] == game.season[0..3]
            season << game.season
        end
        end
        return season
    end

    def best_season(team_id)
        best_season = ""
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        games_by_season = {}
        team_by_id.each do |game|
        if games_by_season[season_games(game.game_id)].nil?
            games_by_season[season_games(game.game_id)] = [game]
        else
            games_by_season[season_games(game.game_id)] << game
        end
        end
        win_tracker = 0.0
        win_percentage = 0.0
        games_by_season.map do |season, games|
        games.each do |game|
            if game.result == "WIN"
            win_tracker += 1.0
            end
        end
        win_percentage = win_tracker / games.count * 100
        games_by_season[season] = win_percentage
        win_tracker = 0.0
        end
        highest = games_by_season.max_by {|season, percentage| percentage}[0]
    end

    def worst_season(team_id)
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        games_by_season = {}
        team_by_id.each do |game|
        if games_by_season[season_games(game.game_id)].nil?
            games_by_season[season_games(game.game_id)] = [game]
        else
            games_by_season[season_games(game.game_id)] << game
        end
        end
        win_tracker = 0.0
        win_percentage = 0.0
        games_by_season.map do |season, games|
        games.each do |game|
            if game.result == "WIN"
            win_tracker += 1.0
            end
        end
        win_percentage = win_tracker / games.count * 100
        games_by_season[season] = win_percentage
        win_tracker = 0.0
        end
        lowest = games_by_season.min_by {|season, percentage| percentage}[0]
    end

    def average_win_percentage(team_id)
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        win_counter = 0.0
        win_loss_tracker = team_by_id.map {|team| team.result}
        win_loss_tracker.each do |result|
        if result == ('WIN')
            win_counter += 1
        end
        end
        percentage = win_counter / win_loss_tracker.count
        percentage.round(2)
    end

    def most_goals_scored(team_id)
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        highest_goals = team_by_id.map do |id|
        id.goals
        end
        highest_goals.sort.pop
        # require 'pry'; binding.pry
    end

    def fewest_goals_scored(team_id)
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        highest_goals = team_by_id.map do |id|
        id.goals
        end
        highest_goals.sort.shift
    end

    def favorite_opponent(team_id)
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        id_of_every_game_played = team_by_id.flat_map {|game_team| game_team.game_id}
        opponents = @game_teams.find_all do |game_team|
        id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id
        end
        teams_by_id = opponents.group_by {|opponent| opponent.team_id}
        # require 'pry'; binding.pry
        opposing_win = 0.0
        teams_by_id.each do |team_id, game_teams|
        game_teams.each do |game_team|
            if game_team.result == 'WIN'
            opposing_win += 1
            end
        end
        opposing_win_percentage = opposing_win / game_teams.count
        teams_by_id[team_id] = opposing_win_percentage
        opposing_win = 0.0
        end
        favorite = teams_by_id.min_by {|team_id, win_percentage| win_percentage}[0]
        @teams.each do |team|
        if team.team_id.include?(favorite)
            return team.team_name
        end
        end
        # require 'pry'; binding.pry
    end

    def rival(team_id)
        team_by_id = @game_teams.find_all do |team|
        team.team_id == team_id
        end
        id_of_every_game_played = team_by_id.flat_map {|game_team| game_team.game_id}
        opponents = @game_teams.find_all do |game_team|
        id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id
        end
        teams_by_id = opponents.group_by {|opponent| opponent.team_id}
        # require 'pry'; binding.pry
        opposing_win = 0.0
        teams_by_id.each do |team_id, game_teams|
        game_teams.each do |game_team|
            if game_team.result == 'WIN'
            opposing_win += 1
            end
        end
        opposing_win_percentage = opposing_win / game_teams.count
        teams_by_id[team_id] = opposing_win_percentage
        opposing_win = 0.0
        end
        least_favorite = teams_by_id.max_by {|team_id, win_percentage| win_percentage}[0]
        @teams.each do |team|
        if team.team_id.include?(least_favorite)
            return team.team_name
        end
        end
    end
    end
>>>>>>> 33ff6352bcea31164d42c77426b8996e39576ee7
