require_dependency "issues_controller"

module RmCustomization
  module Patches
    module IssuesControllerPatch
      def self.included(base)
        base.send(:include, InstanceMethodsForIssuesController)
        base.class_eval do
          alias_method_chain :create, :rm_customization
          alias_method_chain :update, :rm_customization
          #alias_method_chain :destroy, :rm_customization
        end
      end
    end

    module InstanceMethodsForIssuesController
      # def create_with_rm_customization
      #
      # end

      def update_with_rm_customization
        versions_included_in = []
        params['issue']['versions_included_in'].each do |vid|
          versions_included_in << VersionLimited.find(vid.to_i) unless vid.empty?
        end
        @issue.versions_included_in = versions_included_in
        update_without_rm_customization
      end

      def create_with_rm_customization
        versions_included_in = []
        params['issue']['versions_included_in'].each do |vid|
          versions_included_in << VersionLimited.find(vid.to_i) unless vid.empty?
        end
        @issue.versions_included_in = versions_included_in
        create_without_rm_customization
      end
    end

  end
end
