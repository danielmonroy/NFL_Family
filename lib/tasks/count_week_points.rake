task :count_week_points, [:week, :season] => :environment do |task, args|
  week = args[:week].to_i
  season = args[:season].to_i
  data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))
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
