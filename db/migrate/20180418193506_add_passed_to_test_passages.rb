class AddPassedToTestPassages < ActiveRecord::Migration[5.1]
  def change
    add_column :test_passages, :passed, :boolean, default: false, null: false
  end
end
