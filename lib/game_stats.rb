require "csv"
CSV.read("./data/games_truncated.csv")
table = CSV.parse(File.read("./data/games_truncated.csv"), headers: true)
