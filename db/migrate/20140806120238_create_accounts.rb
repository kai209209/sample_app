class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :money
      t.integer :user_id

      t.timestamps
    end
  end
end
