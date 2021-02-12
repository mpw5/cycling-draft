class AddAasmStateToLeague < ActiveRecord::Migration[6.1]
  def change
    add_column :leagues, :aasm_state, :string
  end
end
