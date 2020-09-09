namespace :nfl do
  task :load_games, [:week, :season] => :environment do |task, args|
    week = args[:week].to_i
    season = args[:season].to_i
    data = JSON.load(open("http://static.nfl.com/liveupdate/scores/scores.json"))
    puts data

    data.each do |a, b|
      date = DateTime.new(a.slice(0,4).to_i, a.slice(4,2).to_i, a.slice(6,2).to_i)
      home_team_id = Team.where(short_name: b['home']['abbr']).first.id
      away_team_id = Team.where(short_name: b['away']['abbr']).first.id

      Game.create(id: a.to_i, home_team: home_team_id, away_team: away_team_id,
        scheduled_at: date, home_team_score: (b['home']['score']['T']).to_i,
        away_team_score: (b['away']['score']['T']).to_i, week: week, season: season)
    end
  end

  task :create_pools, [:week, :season] => :environment do |task, args|
    week = args[:week].to_i
    season = args[:season].to_i
    users = User.all
    users.each do |user|
      Pool.create(user_id: user.id, week: week, season: season, total_points: 0)
    end
  end

  task :count_week_points, [:week, :season] => :environment do |task, args|
    week = args[:week].to_i
    season = args[:season].to_i
    data = JSON.load(open("http://static.nfl.com/liveupdate/scores/scores.json"))
    winners_hash = who_win(data)
    pools = Pool.where(week: week, season: season)
    pools.each do |pool|
      points = 0
      pool.forecasts.each do |forecast|
        if(forecast.selection == winners_hash[forecast.game_id.to_s])
          points = points + 1
        end
      end
      pool.total_points = points
      pool.save
    end
  end

  def who_win(data)
    data_hash = Hash.new
    data.each do |a, b|
      if((b['home']['score']['T']).to_i > (b['away']['score']['T']).to_i)
        data_hash[a] = 'home'
      elsif ((b['home']['score']['T']).to_i < (b['away']['score']['T']).to_i)
        data_hash[a] = 'away'
      else
        data_hash[a] = 'draw'
      end
    end
    return data_hash
  end


end
