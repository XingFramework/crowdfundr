class ProjectPledgesMapper < Xing::Mappers::Base
  alias project record
  alias project= record=

  def record_class
    Project
  end

  def update_record
  end

  def assign_values(data_hash)
    @pledges_list = data_hash
  end

  def save
    record_class.transaction do
      perform_mapping
      if self.errors[:data].present?
        raise ActiveRecord::Rollback
      end
      self.record.save
      self.record.pledges.each do |pledge|
        if pledge.changed?
          pledge.save
        end
      end
    end
  end

  def map_nested_models
    old_list = self.record.pledges.to_a
    builder = Xing::Builders::ListBuilder.new(@pledges_list, PledgeMapper)
    list = builder.build

    Pledge.where(:id => (old_list - list).map(&:id)).destroy_all
    self.record.pledges = *list

    self.errors[:data][:pledges].merge!(builder.errors) unless builder.errors.empty?
  end
end
