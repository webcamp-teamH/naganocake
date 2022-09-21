class Public::CustomersController < ApplicationController


  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customers_params)
      redirect_to customers_mypage_path
    else
      render :customers_infomation_edit_path
    end
  end

  def close
    @customer = current_customer
    @customer.update(is_closed: false)
    sign_out
    redirect_to root_path
  end



  private

  def customers_params
    params.require(:customer).permit( :last_name,:first_name, :last_name_kana, :first_name_kana, :address, :postcode, :phone_number)
  end
end
