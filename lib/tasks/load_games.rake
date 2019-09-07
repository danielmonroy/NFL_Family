task :load_games, [:week, :season] => :environment do |task, args|
  week = args[:week].to_i
  season = args[:season].to_i
  data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))

  data.each do |a, b|
    date = DateTime.new(a.slice(0,4).to_i, a.slice(4,2).to_i, a.slice(6,2).to_i)
    home_team_id = Team.where(short_name: b['home']['abbr']).first.id
    away_team_id = Team.where(short_name: b['away']['abbr']).first.id

    Game.create(id: a.to_i, home_team: home_team_id, away_team: away_team_id,
      scheduled_at: date, home_team_score: (b['home']['score']['T']).to_i,
      away_team_score: (b['away']['score']['T']).to_i, week: week, season: season)
  end
end
