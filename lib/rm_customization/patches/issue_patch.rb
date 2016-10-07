module RmCustomization
  module Patches
    module IssuePatch
      def self.included(base)
        base.class_eval do
          belongs_to :fixed_version, :class_name => 'VersionLimited'
          has_and_belongs_to_many :versions_included_in, :class_name => 'VersionLimited',
                                  :join_table => "versions_issues", :foreign_key => "issue_id",
                                  :association_foreign_key => "version_id"
        end
      end
    end
  end
end
