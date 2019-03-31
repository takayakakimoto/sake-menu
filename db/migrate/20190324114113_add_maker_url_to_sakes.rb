class AddMakerUrlToSakes < ActiveRecord::Migration[5.0]
  def change
    add_column :sakes, :maker_url, :string
  end
end
