module ProjectsHelper
  
  def formatted_project_link(project)
    link_to project.name, project_path(project)
  end
  
end
