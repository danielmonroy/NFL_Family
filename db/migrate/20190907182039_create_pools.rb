class CreatePools < ActiveRecord::Migration[5.2]
  def change
    create_table :pools do |t|
      t.references :user, foreign_key: true
      t.integer :week
      t.integer :season
      t.integer :total_points

      t.timestamps
    end
  end
end
