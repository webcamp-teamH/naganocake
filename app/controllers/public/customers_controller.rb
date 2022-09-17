class Public::CustomersController < ApplicationController


  def show
    @customer = current_customer
  end

  private

  def customers_params
    params.require(:customer).permit( :last_name,:first_name, :last_name_kana, :first_name_kana, :address, :postcode, :phone_number)
  end
end
