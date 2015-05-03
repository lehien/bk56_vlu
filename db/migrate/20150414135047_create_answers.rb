class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question, index: true
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :vote, :default => 0
      t.timestamps
    end
  end
end
