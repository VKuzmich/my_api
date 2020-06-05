

class CreateTransformers < ActiveRecord::Migration[6.0]
  def change
    create_table :transformers do |t|
      t.string :user_url
      t.string :nickname

      t.timestamps
    end
  end
end
