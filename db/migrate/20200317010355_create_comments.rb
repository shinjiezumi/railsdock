class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :board, null: false, foreign_key: true
      # [MEMO] null: falseをつけるとNotNULL制約
      t.string :name, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
