class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads do |t|
      t.string :link
      t.string :reference
      t.boolean :archived, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :uploads, :reference, unique: true
  end
end
