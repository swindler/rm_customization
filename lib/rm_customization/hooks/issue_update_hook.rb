module RmCustomization
  class IssueUpdateHook < Redmine::Hook::ViewListener
    def controller_issues_edit_before_save(context={})
      minus = IssueStatus.find_by_name("REOPENED")
      issue = context[:issue]
      if issue.status_id == minus.id && issue.status_id_was != minus.id
        issue.priority = IssuePriority.find_by_name('-1')
      end
    end

    alias :controller_issues_bulk_edit_before_save :controller_issues_edit_before_save
  end

end