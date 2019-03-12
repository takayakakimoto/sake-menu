class CreateSakes < ActiveRecord::Migration[5.0]
  def change
    create_table :sakes do |t|
      t.string :identify_code
      t.string :name
      t.string :furigana

      t.timestamps
    end
  end
end
