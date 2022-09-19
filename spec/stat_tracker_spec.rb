# require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  # it 'exists' do
  #   expect(@stat_tracker).to be_a(StatTracker)
  # end

  # it '#highest_total_score' do
  #   expect(@stat_tracker.highest_total_score).to eq(5)
  # end

  # it "#lowest_total_score" do
  #   expect(@stat_tracker.lowest_total_score).to eq(1)
  # end

  # it "#percentage_home_wins" do
  #   expect(@stat_tracker.percentage_home_wins).to eq(0.33)
  # end

  # it '#percentage_visitor_wins' do
  #   expect(@stat_tracker.percentage_visitor_wins).to eq(0.33)
  # end

  # it '#percent_total_ties' do
  #   expect(@stat_tracker.percentage_ties).to eq(0.33)
  # end
  # it '#total_games' do
  #   expect(@stat_tracker.total_games).to eq(9)
  # end

  # it '#total_home_wins' do
  #   expect(@stat_tracker.total_home_wins).to eq(3)
  # end

  # it '#total_home_losses' do
  #   expect(@stat_tracker.total_home_losses).to eq(3)
  # end

  # it '#total_ties' do
  #   expect(@stat_tracker.total_ties).to eq(3)
  # end

  # it '#total_away_losses' do
  #   expect(@stat_tracker.total_away_losses).to eq(@stat_tracker.total_home_wins)
  # end

  # it '#total_away_wins' do
  #   expect(@stat_tracker.total_away_wins).to eq(@stat_tracker.total_home_losses)
  # end

  # it '#count_of_games_by_season' do
  #   expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>4, "20142015"=>4, "20152016"=>1})
  # end

  # it '#average_goals_per_game' do
  #   expect(@stat_tracker.average_goals_per_game).to eq(4.0)
  # end

  # it '#average_goals_by_season' do
  #   expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.5, "20142015"=>4.5, "20152016"=>4.0})
  # end

  # it '#count_of_teams' do
  #   expect(@stat_tracker.count_of_teams).to eq(32)
  # end

  # it '#average_goals' do
  #   expect(@stat_tracker.average_goals).to eq({"16"=>1.0, "17"=>2.0, "24"=>2.0, "25"=>2.0, "26"=>3.0, "8"=>2.5, "9"=>1.0})
  # end

  # it '#best_offense' do
  #   expect(@stat_tracker.best_offense).to eq('FC Cincinnati')
  # end

  # it '#worst_offense' do
  #   expect(@stat_tracker.worst_offense). to eq('New England Revolution')
  # end

  # it '#highest_scoring_visitor' do
  #   expect(@stat_tracker.highest_scoring_visitor).to eq('FC Cincinnati')
  # end

  # it '#highest_scoring_home_team' do
  #   expect(@stat_tracker.highest_scoring_home_team).to eq('New York Red Bulls')
  # end

  # it '#lowest_scoring_visitor' do
  #   expect(@stat_tracker.lowest_scoring_visitor).to eq('New England Revolution')
  # end

  # it '#lowest_scoring_home_team' do
  #   expect(@stat_tracker.lowest_scoring_home_team).to eq('New York City FC')
  # end
  
  it '#team_info' do
    expect(@stat_tracker.team_info('18')).to eq({
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
      })
    end
    
    it '#total_wins_per_season' do
      expect(@stat_tracker.total_wins_per_season('6')).to eq({"20122013"=>2})
    end
    
    it '#total_games_played_per_season' do
      expect(@stat_tracker.total_games_played_per_season('6')).to eq({"20122013"=>4})
    end
    
    it '#best_season' do
      expect(@stat_tracker.best_season('6')).to eq("20122013")
    end
    
    it '#worst_season' do
      expect(@stat_tracker.worst_season('6')).to eq("20122013")
    end
    
    it '#average_win_percentage' do
      expect(@stat_tracker.average_win_percentage('6')).to eq(0.5)
    end
    
    it '#most_goals_scored' do
      expect(@stat_tracker.most_goals_scored('8')).to eq(3)
    end
    
    it "#fewest_goals_scored" do
      expect(@stat_tracker.fewest_goals_scored('16')).to eq(0)
    end
    
    # it '#favorite_opponent' do
    #   expect(@stat_tracker.favorite_opponent('6')).to eq("Houston Dynamo")
    # end

    it "#most_tackles" do
      expect(@stat_tracker.most_tackles("20122013")).to eq "LA Galaxy"
      expect(@stat_tracker.most_tackles("20142015")).to eq "New York City FC"
    end
  
    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Chicago Red Stars"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "New York Red Bulls"
    end
  end
 
  # it '#team_info' do
  #   expect(@stat_tracker.team_info('18')).to eq({
  #     "team_id" => "18",
  #     "franchise_id" => "34",
  #     "team_name" => "Minnesota United FC",
  #     "abbreviation" => "MIN",
  #     "link" => "/api/v1/teams/18"
  #   })
  # end

  # it '#total_wins_per_season' do
  #   expect(@stat_tracker.total_wins_per_season('6')).to eq({"20122013"=>2})
  # end

  # it '#total_games_played_per_season' do
  #   expect(@stat_tracker.total_games_played_per_season('6')).to eq({"20122013"=>4})
  # end

  # it '#best_season' do
  #   expect(@stat_tracker.best_season('6')).to eq("20122013")
  # end

  # it '#worst_season' do
  #   expect(@stat_tracker.worst_season('6')).to eq("20122013")
  # end

  # it '#average_win_percentage' do
  #   expect(@stat_tracker.average_win_percentage('6')).to eq(0.5)
  # end

  # it '#most_goals_scored' do
  #   expect(@stat_tracker.most_goals_scored('8')).to eq(3)
  # end

  # it "#fewest_goals_scored" do
  #   expect(@stat_tracker.fewest_goals_scored('16')).to eq(0)
  # end

  # it '#favorite_opponent' do
  #   expect(@stat_tracker.favorite_opponent('6')).to eq("Houston Dynamo")
  # end
  
  it '#find_season' do
    expect(@stat_tracker.find_season('20122013').first).to be_a(CSV::Row)

    expect(@stat_tracker.find_season('20102011')).to eq([])
  end
  
  it '#total_goals' do
    expect(@stat_tracker.total_goals('20122013')).to eq({"17"=>6.0, "16"=>2.0})
  end
  
  it '#total_shots' do
    expect(@stat_tracker.total_shots('20122013')).to eq({"17"=>19.0, "16"=>18.0})
  end
  
  it '#most_accurate_team' do
    expect(@stat_tracker.most_accurate_team('20142015')).to eq('New York Red Bulls')
  end

  it '#least_accurate_team' do
    expect(@stat_tracker.least_accurate_team('20142015')).to eq('New York City FC')


  it '#total_games_played_per_team(season)' do
    expect(@stat_tracker.total_games_played_per_team("20122013")).to eq({"Mike Babcock"=>3, "Joel Quenneville"=>2})                                                                
  end

  it '#total_wins_per_team(season)' do
    expect(@stat_tracker.total_wins_per_team('20122013')).to eq({"Mike Babcock"=>2, "Joel Quenneville"=>1})
  end
  
  it '#winningest_coach(season)' do 
    expect(@stat_tracker.winningest_coach('20122013')).to eq("Mike Babcock")
  end

  it '#worst_coach(season)' do
    expect(@stat_tracker.worst_coach('20122013')).to eq("Joel Quenneville")
  end

end

