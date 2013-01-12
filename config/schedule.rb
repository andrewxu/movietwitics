
every :hour do
  rake "twitter:import_sentiment"
end

every 5.minutes do
  rake "twitter:migrate_sentiment"
end
