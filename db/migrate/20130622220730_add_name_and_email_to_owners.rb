class AddNameAndEmailToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :name, :string
  end
end
