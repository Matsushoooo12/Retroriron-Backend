class CreateDiscographies < ActiveRecord::Migration[6.1]
  def change
    create_table :discographies do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.string :image, null: false
      t.string :mv_link
      t.string :subscription_link
      t.integer :tag

      t.timestamps
    end
  end
end
