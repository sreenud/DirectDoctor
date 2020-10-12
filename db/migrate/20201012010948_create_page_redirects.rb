class CreatePageRedirects < ActiveRecord::Migration[6.0]
  def change
    create_table :page_redirects do |t|
      t.string(:old)
      t.string(:new)
      t.integer(:redirect_code)

      t.timestamps
    end
  end
end
