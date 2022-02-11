module Admin::ProgramsHelper
  def program_category_selection
    ProgramCategory.select(:name, :id).map{ |category| [category.name, category.id] }
  end

  def currency_selection
    Currency.select(:name, :id).map{ |currency| [currency.name, currency.id] }
  end

  def program_type_selection
  ProgramType.select(:name, :id).map{ |type| [type.name, type.id] }
  end
end
