class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :location

      t.timestamps
    end
  end
end
