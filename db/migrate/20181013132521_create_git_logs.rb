class CreateGitLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :git_logs do |t|
      t.string :author_name
      t.datetime :author_date
      t.string :contributor_name
      t.datetime :contributor_date
      t.integer :change_loc
      t.integer :plus_loc
      t.integer :minus_loc
      t.string :comment

      t.timestamps
    end
  end
end
