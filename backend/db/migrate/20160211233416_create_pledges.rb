class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.decimal :amount
      t.text :comment
      t.references :project, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
