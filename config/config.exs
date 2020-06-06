use Mix.Config

if Mix.env() == :test do
  config :exvcr,
    vcr_cassette_library_dir: "test/fixture/vcr_cassettes",
    filter_sensitive_data: [
      [pattern: "token [^\"]+", placeholder: "token yourtokencomeshere"]
    ]
end
