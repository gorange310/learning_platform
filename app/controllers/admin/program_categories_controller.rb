class Admin::ProgramCategoriesController < Admin::AdminController
  before_action :set_category, :only => %w[edit update destroy]

  def index
    @categories = ProgramCategory.all
  end

  def new
    @category = ProgramCategory.new
  end

  def create
    @category = ProgramCategory.new(category_params)

    if @category.save!
      flash[:notice] = "新增課程主題 #{ @category.name }"
      redirect_to admin_program_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "更新課程主題 #{ @category.name }"
      redirect_to admin_program_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "移除課程主題 #{ @category.name }"
    redirect_to admin_program_categories_path
  end


  private

  def set_category
    @category = ProgramCategory.find(params[:id])
  end

  def category_params
    params.require(:program_category).permit(:name)
  end
end
