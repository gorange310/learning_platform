class Admin::ProgramsController < Admin::AdminController
  before_action :set_program, :only => %w[edit update destroy]

  def index
    @programs = Program.includes(:category, :type, :currency)
  end

  def new
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)

    if @program.save!
      flash[:notice] = "新增課程 #{ @program.name }"
      redirect_to admin_programs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @program.update(program_params)
      flash[:notice] = "更新課程 #{ @program.name }"
      redirect_to admin_programs_path
    else
      render :edit
    end
  end

  def destroy
    @program.destroy
    flash[:notice] = "移除課程 #{ @program.name }"
    redirect_to admin_programs_path
  end


  private

  def set_program
    @program = Program.find(params[:id])
  end

  def program_params
    params.require(:program).permit(
      :name, :program_category_id, :price, :currency_id,
      :program_type_id, :status, :url, :description, :validity_period
    )
  end
end
