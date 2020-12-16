class ReviewData < ApplicationRecord
  self.table_name = 'review_datas'

  def readonly?
    true
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: true, cascade: false)
  end

  def self.refresh!
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end
end
