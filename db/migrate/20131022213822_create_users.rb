class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email, :password_hash, :first_name, :last_name
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
