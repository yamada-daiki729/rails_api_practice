class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :contents
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
