ExUnit.start
ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
ExVCR.Config.filter_sensitive_data("token [^\"]+", "token yourtokencomeshere")