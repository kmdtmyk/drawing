crumb :root do
  link 'Top', root_path
end

crumb :drawings do
  link '図面一覧', drawings_path
  parent :root
end

crumb :drawing_show do
  link '詳細'
  parent :drawings
end

crumb :drawing_new do
  link '新規'
  parent :drawings
end

crumb :drawing_edit do
  link '編集'
  parent :drawings
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
