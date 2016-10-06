class CreateVersionsTrackers < ActiveRecord::Migration
  def change
    create_table :versions_trackers, id: false do |t|
      t.belongs_to :version
      t.belongs_to :tracker
    end
  end
end