require_dependency "issues_controller"

module RmCustomization
  module Patches
    module IssuesControllerPatch
      # def self.included(base)
      #   base.send(:include, InstanceMethodsForIssuesController)
      #   base.class_eval do
      #     alias_method_chain :respond_to, :rm_customization
      #   end
      # end
    end

    module InstanceMethodsForIssuesController
      # def respond_to_with_rm_customization(&block)
      #   if @project && @content
      #     if @_action_name == 'show'
      #       redmine_tweaks_include_header
      #       redmine_tweaks_include_footer
      #     end
      #   end
      #   respond_to_without_rm_customization(&block)
      # end
    end

  end
end
