class CreateIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :identities do |t|
      t.string :login
      t.string :encrypted_password

      t.timestamps
    end
  end
end
