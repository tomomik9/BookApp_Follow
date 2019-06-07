class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :title, null: false
      t.text :memo, null: false

      t.timestamps
    end
  end
end
