class ProjectMapper < Xing::Mappers::Base
  alias project record
  alias project= record=

  def record_class
    Project
  end

  def assign_values(data_hash)
    @project_data = data_hash
    super
  end

  def update_record
    self.project.assign_attributes(@project_data)
  end

end
