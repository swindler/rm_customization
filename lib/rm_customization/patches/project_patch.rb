module RmCustomization
  module Patches
    module ProjectPatch
      def self.included(base)
        base.class_eval do
          has_many :versions, ->(obj) {VersionLimited.limited(obj)}, :dependent => :destroy, :class_name => 'VersionLimited'
        end
      end
    end
  end
end
