task :create_pools, [:week, :season] => :environment do |task, args|
  week = args[:week].to_i
  season = args[:season].to_i
  users = User.all
  users.each do |user|
    Pool.create(user_id: user.id, week: week, season: season)
  end
end
