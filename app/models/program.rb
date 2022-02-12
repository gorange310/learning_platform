class Program < ApplicationRecord
  STATUS = {
    :active => '上架',
    :inactive => '下架'
  }

  belongs_to :category, :class_name => 'ProgramCategory', :foreign_key => 'program_category_id', :optional => true
  belongs_to :type, :class_name => 'ProgramType', :foreign_key => 'program_type_id'
  belongs_to :currency, :optional => true

  validates :status, :presence => true
  validates :validity_period, :presence => true

  def is_inactive?
    self.status == 'inactive'
  end
end
