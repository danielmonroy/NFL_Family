class Pool < ApplicationRecord
  belongs_to :user
  has_many :forecasts
  after_create :make_forecasts

  def make_forecasts
    @week_games = Game.where(week: self.week, season: self.season)
    @week_games.each do |game|
      Forecast.create(game_id: game.id, pool_id: self.id)
    end
  end
end
