class AddDraftForwardToLeague < ActiveRecord::Migration[6.1]
  def change
    add_column :leagues, :draft_forward, :boolean, null: false, default: true
  end
end
