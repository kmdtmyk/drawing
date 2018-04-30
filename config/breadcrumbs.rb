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



crumb :customers do
  link '顧客一覧', customers_path
  parent :root
end

crumb :customer_new do
  link '新規'
  parent :customers
end

crumb :customer_edit do
  link '編集'
  parent :customers
end


crumb :materials do
  link '材質一覧', materials_path
  parent :root
end

crumb :material_new do
  link '新規'
  parent :materials
end

crumb :material_edit do
  link '編集'
  parent :materials
end

crumb :processing_types do
  link '加工種類一覧', processing_types_path
  parent :root
end

crumb :processing_type_new do
  link '新規'
  parent :processing_types
end

crumb :processing_type_edit do
  link '編集'
  parent :processing_types
end


crumb :users do
  link 'ユーザー一覧', admin_users_path
  parent :root
end

crumb :user_new do
  link '新規'
  parent :users
end

crumb :user_edit do
  link '編集'
  parent :users
end

crumb :notices do
  link 'お知らせ一覧', notices_path
  parent :root
end

crumb :notice_new do
  link '新規'
  parent :notices
end

crumb :notice_edit do
  link '編集'
  parent :notices
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
