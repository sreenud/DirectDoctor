class AddAddressSuiteToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :address_suite, :string)
  end
end
