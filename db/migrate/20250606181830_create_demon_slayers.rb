class CreateDemonSlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :demon_slayers do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :kanji, null: false
      t.string :kanji_meaning
      t.integer :power, null: false, default: 1, limit: 1 # 1 a 100
      t.datetime :deleted_at, index: true # borrado lógico

      t.timestamps
    end
  end
end
