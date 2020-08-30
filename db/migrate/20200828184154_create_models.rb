class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.integer :reports, default: 0
      t.boolean :infected, default: false
      t.timestamps
    end

    create_table :locations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.belongs_to :survivor

      t.timestamps
    end

    create_table :inventories do |t|
      t.integer :capacity
      t.belongs_to :survivor
      t.timestamps
    end

    create_table :items do |t|
      t.string :name
      t.integer :value
      t.integer :amount, default: 0
      t.float :weight, default: 0
      t.belongs_to :inventory

      t.timestamps
    end

    
  end
end
