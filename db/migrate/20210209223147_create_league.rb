class CreateLeague < ActiveRecord::Migration[6.1]
  def change
    create_table :leagues, id: :uuid do |t|
      t.text :name
      t.timestamps
    end
  end
end
