class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name,       null: false
      t.integer :groups
      t.boolean :immutable, default: false, null: false

      t.timestamps null: false
    end
    create_table :users do |t|
      t.string :first_name,       null: false
      t.string :last_name
      t.string :email,            null: false
      t.string :password_digest,  null: false
      t.string :activation_token, null: false
      t.string :locale,           null: false, default: "pt-PT"
      t.string :phone_number,     null: false, unique: true
      t.timestamps
    end
    create_table :user_roles do |t|
      t.references :user
      t.references :role
    end

    add_index :user_roles, [:user_id, :role_id], unique: true
  end
end
