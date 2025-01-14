class CreateDirectories < ActiveRecord::Migration[7.0]
  def change
    create_table :directories, id: :uuid do |t|
      t.string :dirname, null: false
      t.references :parent, foreign_key: { to_table: :directories }, type: :uuid

      t.index %i[dirname parent_id], unique: true

      t.timestamps
    end
  end
end
