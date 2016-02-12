class PledgeMapper < Xing::Mappers::Base
  alias pledge record
  alias pledge= record=

  def record_class
    Pledge
  end

  def assign_values(data_hash)
    @pledge_data = data_hash
    super
  end

  def update_record
    if @links[:project].present?
      self.pledge.project_id = route_to(@links[:project])[:id]
    end

    if @links[:user].present?
      self.pledge.user_id = route_to(@links[:user])[:id]
    end

    self.pledge.assign_attributes(@pledge_data)
  end
end

