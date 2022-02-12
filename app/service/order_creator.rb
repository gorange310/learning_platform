class OrderCreator
  def initialize(user, program_id)
    @user = user
    @program_id = program_id
    @program = Program.find(program_id)
  end

  def send_order
    @user_program = find_user_program
    ## 若課程已下架，則不能進行購買
    return false if @program.is_inactive?
    ## 若使用者已購買過該課程，且目前還可以取用，則不允許重複購買
    return false if @user_program&.is_valid?

    ## 紀錄學生課程有效期
    @user_program ||= @user.user_programs.new(program_id: @program_id)
    @user_program.expired_date = (Date.today + @program.validity_period)
    @user_program.save!

    ## 購買後須建立購買紀錄
    new_order = @user_program.orders.create!(
      status: 'paid',
      amount: @program.price,
      currency_id: @program.currency_id,
      date: Date.today
    )

    return new_order
  end

  private

  def find_user_program
    @user.user_programs.find{ |user_program| user_program.program_id == @program_id }
  end
end
