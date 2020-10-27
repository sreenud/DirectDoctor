class RenamePriceRangeFieldsInDoctor < ActiveRecord::Migration[6.0]
  def change
    rename_column(:doctors, :minimum_price, :min_price)
    rename_column(:doctors, :maximum_price, :max_price)
  end
end
