class AddPasswordDigestToMusician < ActiveRecord::Migration[6.0]
  def change
    add_column :musicians, :password_digest, :string
    add_column :musicians, :username, :string
  end
end
