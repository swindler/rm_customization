# Redmine Customization plugin for SS

require 'redmine'

Redmine::Plugin.register :rm_customization do
  name 'Redmine SS Customization'
  author 'Artyom Borkowsky'
  description 'Customizing workflow for SS requirements'
  version '0.0.1'
end

require 'rm_customization/hooks/issue_update_hook'
