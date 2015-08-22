class AddUserPublicKey < ActiveRecord::Migration
  def change
    add_column :cbe_users, :pubkey, :text, after: 'email'
    add_column :cbe_users, :privkey, :text, after: 'pubkey'
  end
end
