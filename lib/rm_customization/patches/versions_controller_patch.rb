require_dependency "versions_controller"

module RmCustomization
  module Patches
    module VersionsControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethodsForVersionsController)
        base.class_eval do
          alias_method_chain :index, :rm_customization
        end
      end
    end

    module InstanceMethodsForVersionsController
      def index_with_rm_customization
        project = Project.find_by_identifier(params['project_id'])
        respond_to do |format|
          format.html {
            @versions = index_without_rm_customization
            @versions += VersionLimited.limited(project)
            @versions = @versions.uniq.sort
          }
          format.api {
            @versions = index_without_rm_customization
            @versions += VersionLimited.limited(project)
            @versions = @versions.uniq.sort
          }
        end

      end
    end

  end
end
