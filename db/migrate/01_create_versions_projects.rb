class CreateVersionsProjects < ActiveRecord::Migration
  def change
    create_table :versions_projects, id: false do |t|
      t.belongs_to :version
      t.belongs_to :project
    end
  end
end