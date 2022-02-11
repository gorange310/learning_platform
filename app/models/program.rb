class Program < ApplicationRecord
  STATUS = {
    :on => '上架',
    :off => '下架'
  }

  belongs_to :category, :class_name => 'ProgramCategory', :foreign_key => 'program_category_id'
  belongs_to :type, :class_name => 'ProgramType', :foreign_key => 'program_type_id'
  belongs_to :currency

  validates :status, :presence => true
  validates :validity_period, :presence => true
end
