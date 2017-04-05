class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @user = Adapter::Marqeta.new_user
  end
end
