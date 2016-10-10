module RmCustomization
  module Patches
    module IssuePatch
      def self.included(base)
        base.send(:include, InstanceMethodsForIssue)
        base.class_eval do
          belongs_to :fixed_version, :class_name => 'VersionLimited'
          has_and_belongs_to_many :versions_included_in, :class_name => 'VersionLimited',
                                  :join_table => "versions_issues", :foreign_key => "issue_id",
                                  :association_foreign_key => "version_id"
          alias_method_chain :assignable_versions, :rm_customization
        end
      end
    end

    module InstanceMethodsForIssue
      def assignable_versions_with_rm_customization
        return @assignable_versions if @assignable_versions
        @assignable_versions = assignable_versions_without_rm_customization
        @assignable_versions += VersionLimited.limited(project)
        @assignable_versions = @assignable_versions.collect { |x| x.id }
        @assignable_versions = VersionLimited.find(@assignable_versions).uniq.sort

      end
    end
  end
end
