class CreateRepos < ActiveRecord::Migration[7.0]
  def change
    create_table :repos do |t|
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
