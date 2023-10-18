class RenamePhoneNamberColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :phone_namber, :phone_number
  end
end
