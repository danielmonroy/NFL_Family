class Forecast < ApplicationRecord
  belongs_to :game
  belongs_to :pool
end
