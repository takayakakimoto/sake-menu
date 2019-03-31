class AddMakerNameToSakes < ActiveRecord::Migration[5.0]
  def change
    add_column :sakes, :maker_name, :string
  end
end
