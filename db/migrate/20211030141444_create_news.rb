class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.text :content, null: false
      t.string :image
      t.boolean :image_vertical

      t.timestamps
    end
  end
end
