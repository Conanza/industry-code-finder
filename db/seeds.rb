tr = TableReader.new
tr.parse_csv("#{Rails.root}/public/data/fastcompclasscodecrossreferenceguide.csv")
tr.output_performance_stats
