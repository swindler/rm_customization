class VersionLimited < Version
  has_and_belongs_to_many :projects, :join_table => "versions_projects", :foreign_key => "version_id"
  has_and_belongs_to_many :trackers, :join_table => "versions_trackers", :foreign_key => "version_id"
  has_and_belongs_to_many :issues, :join_table => "versions_issues", :foreign_key => "version_id"

  scope :limited, lambda { |project, tracker|
    joins(:projects).
        joins(:trackers).
        where(trackers: {id: tracker.id}).
        where(projects: {id: project.id})
  }
end
