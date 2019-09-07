class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.references :game, foreign_key: true
      t.references :pool, foreign_key: true
      t.string :selection

      t.timestamps
    end
  end
end
