class RenamePlaceColumnToLive < ActiveRecord::Migration[6.1]
  def change
    rename_column :lives, :place, :venue
  end
end
