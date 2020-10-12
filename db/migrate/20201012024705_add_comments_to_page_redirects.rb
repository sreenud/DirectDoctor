class AddCommentsToPageRedirects < ActiveRecord::Migration[6.0]
  def change
    add_column(:page_redirects, :comments, :text)
    add_reference(:page_redirects, :user, index: true)
  end
end
