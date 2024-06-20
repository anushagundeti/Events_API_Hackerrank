class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.boolean :public
      t.integer :repo_id
      t.integer :actor_id
    end
  end
end
