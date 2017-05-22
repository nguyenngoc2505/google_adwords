class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.references :user, index: true, foreign_key: true
      t.string :keyword
      t.integer :top_adwords_count, null: false, default: 0
      t.integer :bottom_adwords_count, null: false, default: 0
      t.integer :adwords_count, null: false, default: 0
      t.text :top_adwords_urls
      t.text :bottom_adwords_urls
      t.integer :non_adwords_count, null: false, default: 0
      t.text :non_adwords_urls
      t.integer :total_urls, null: false, default: 0
      t.string :total_results, null: false, default: ""
      t.text :content

      t.timestamps
    end
  end
end
