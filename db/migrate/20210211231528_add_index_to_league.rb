class AddIndexToLeague < ActiveRecord::Migration[6.1]
  def change
    change_table :leagues do |t|
      t.index :name, unique: true
    end
  end
end
