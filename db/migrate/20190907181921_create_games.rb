class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :home_team
      t.integer :away_team
      t.datetime :scheduled_at
      t.integer :home_team_score
      t.integer :away_team_score
      t.integer :week
      t.integer :season
      t.boolean :editable, default: true

      t.timestamps
    end
  end
end
