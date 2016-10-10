class CreatePageLayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :page_layouts do |t|
      t.string :page_layout

      t.timestamps
    end
  end
end
