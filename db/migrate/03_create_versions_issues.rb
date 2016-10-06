class CreateVersionsIssues < ActiveRecord::Migration
  def change
    create_table :versions_issues, id: false do |t|
      t.belongs_to :version
      t.belongs_to :issue
    end
  end
end