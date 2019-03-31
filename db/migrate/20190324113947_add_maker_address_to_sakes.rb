class AddMakerAddressToSakes < ActiveRecord::Migration[5.0]
  def change
    add_column :sakes, :maker_address, :string
  end
end
