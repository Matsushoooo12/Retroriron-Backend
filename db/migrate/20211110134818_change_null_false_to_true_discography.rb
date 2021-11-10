class ChangeNullFalseToTrueDiscography < ActiveRecord::Migration[6.1]
  def change
    change_column_null :discographies, :date, true
  end
end
