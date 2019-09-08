class GamesController < ApplicationController
  before_action :authenticate_user!
  def index
    @games = Game.all.order(scheduled_at: :desc)
  end
end
