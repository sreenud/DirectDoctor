class CreateReviewDatas < ActiveRecord::Migration[6.0]
  def change
    create_view :review_datas, materialized: true
  end
end
