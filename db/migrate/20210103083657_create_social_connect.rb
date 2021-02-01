class CreateSocialConnect < ActiveRecord::Migration[6.0]
  def change
    create_table(:social_connects) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.string(:provider)
      t.string(:uid)
      t.string(:access_token)
      t.string(:access_token_secret)
      t.string(:refresh_token)
      t.datetime(:expires_at)
      t.text(:auth)

      t.timestamps
    end
  end
end
