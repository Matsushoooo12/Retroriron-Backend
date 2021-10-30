class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :date, null: false
      t.string :title, null: false
      t.string :name_kana, null: false
      t.integer :number, null: false
      t.string :email, null: false
      t.text :description

      t.timestamps
    end
  end
end
