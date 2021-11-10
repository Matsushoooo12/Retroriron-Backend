class ChangeNullFalseToTrueNews < ActiveRecord::Migration[6.1]
  def change
    change_column_null :news, :date, true
  end
end
