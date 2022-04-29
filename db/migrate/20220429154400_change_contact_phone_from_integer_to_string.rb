class ChangeContactPhoneFromIntegerToString < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :phone, :string
  end
end
