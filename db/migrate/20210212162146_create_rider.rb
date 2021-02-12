class CreateRider < ActiveRecord::Migration[6.1]
  def change
    create_table :riders, id: :uuid do |t|
      t.text :name
      t.text :team
      t.text :country
      t.numeric :price
      t.numeric :previous_score
      t.numeric :score
      t.timestamps
    end
  end
end
