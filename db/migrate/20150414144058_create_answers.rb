class CreateAnswers < ActiveRecord::Migration
  def change
    drop_table :answers 
    create_table :answers do |t|
      t.references :question, index: true
      t.text :body
      t.integer :vote

      t.timestamps
    end
  end
end
