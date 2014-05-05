class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.date :date
      t.float :weight
      t.references :user, index: true

      t.timestamps
    end
  end
end
