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
