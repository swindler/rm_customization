# Redmine Customization plugin for SS

require 'redmine'

Redmine::Plugin.register :rm_customization do
  name 'Redmine SS Customization'
  author 'Artyom Borkowsky'
  description 'Customizing workflow for SS requirements. Overrides Redmine Versions so that each has
                permissions on each project and tracker where it can be assigned to'
  version '0.0.2'
end

require_dependency 'rm_customization/hooks/issue_update_hook'
Issue.send(:include, RmCustomization::Patches::IssuePatch)
Project.send(:include, RmCustomization::Patches::ProjectPatch)
IssuesController.send(:include, RmCustomization::Patches::IssuesControllerPatch)
VersionsController.send(:include, RmCustomization::Patches::VersionsControllerPatch)
