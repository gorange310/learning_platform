class Admin::ProgramTypesController < Admin::AdminController
  before_action :set_type, :only => %w[edit update destroy]

  def index
    @types = ProgramType.all
  end

  def new
    @type = ProgramType.new
  end

  def create
    @type = ProgramType.new(type_params)

    if @type.save!
      flash[:notice] = "新增類別主題 #{ @type.name }"
      redirect_to admin_program_types_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @type.update(type_params)
      flash[:notice] = "更新類別主題 #{ @type.name }"
      redirect_to admin_program_types_path
    else
      render :edit
    end
  end

  def destroy
    @type.destroy
    flash[:notice] = "移除類別主題 #{ @type.name }"
    redirect_to admin_program_types_path
  end


  private

  def set_type
    @type = ProgramType.find(params[:id])
  end

  def type_params
    params.require(:program_type).permit(:name)
  end
end
