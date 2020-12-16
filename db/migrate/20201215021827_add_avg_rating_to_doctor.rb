class AddAvgRatingToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :avg_rating, :decimal, precision: 6, scale: 1)
  end
end
