class ChangeNullFalseToTrueLive < ActiveRecord::Migration[6.1]
  def change
    change_column_null :lives, :date, true
  end
end
