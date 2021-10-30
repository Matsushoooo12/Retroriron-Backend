class CreateLives < ActiveRecord::Migration[6.1]
  def change
    create_table :lives do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.time :open_time
      t.time :start_time
      t.string :place
      t.string :price
      t.text :detail
      t.string :image
      t.boolean :image_vertical
      t.string :performer

      t.timestamps
    end
  end
end
