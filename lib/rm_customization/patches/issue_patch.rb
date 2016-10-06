module RmCustomization
  module Patches
    module IssuePatch
      def self.included(base)
        base.class_eval do
          belongs_to :fixed_version, :class_name => 'VersionLimited'
          has_many :versions_found_in, :class_name => 'VersionLimited'
          has_many :versions_included_in, :class_name => 'VersionLimited'
        end
      end
    end
  end
end
