class GamesController < ApplicationController
  def index
    @games = Game.all.order(scheduled_at: :desc)
  end
end
