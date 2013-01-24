class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :god
      t.string :brand
      t.string :model
      t.string :generation
      t.string :modification
      t.string :dvigatel
      t.string :tip
      t.string :moschnost
      t.string :privod
      t.string :tip_kuzova
      t.string :kpp
      t.string :kod_kuzova
      t.string :kod_dvigatelya
      t.string :rinok
      t.string :vin
      t.string :frame
      t.string :komplektaciya
      t.text :notes_invisible
      t.integer :user_id
      t.integer :creator_id
      # TODO аналогично видимость (свертка/развертка)
      t.boolean :visible

      t.timestamps
    end
    add_index :cars, :user_id
  end
end
