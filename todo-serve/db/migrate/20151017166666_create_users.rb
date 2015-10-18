class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :pin
      t.string :name
      t.string :phone
      t.boolean :verify, :default => false

      t.timestamps null: false
    end
  end
end
