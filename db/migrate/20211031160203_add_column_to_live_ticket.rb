class AddColumnToLiveTicket < ActiveRecord::Migration[6.1]
  def change
    add_column :lives, :ticket_link, :string
  end
end
