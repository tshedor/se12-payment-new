class PaymentsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @sender_payments = Payment.where(sender_id: "#{current_user.id}", paid: false).all
    @recipient_payments = Payment.where(recipient_id: "#{current_user.id}", paid: false).all

    @net_total = current_user.owed
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find_by_id(params[:id])
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    if payment_params[:sender_id] != payment_params[:recipient_id]
      if @payment.save
        redirect_to payments_path
        flash[:success] = "Payment created successfully!"
      else
        flash.now[:error] = @payment.errors.full_messages
        render :new
      end
    else
      flash.now[:error] = []
      flash.now[:error] << "Sender and recipient must be different."
      render :new
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    set_payment
      if @payment.update(payment_params)
        redirect_to payments_path
        flash[:success] = "Payment updated successfully!"
      else
        flash.now[:error] = @payment.errors.full_messages
        render :edit
    end
  end

  def paid
    payment = Payment.find(params[:id])
    unless payment.paid?
      payment.update_attribute(:paid, true)
      render json: { msg: true, amount: current_user.owed }
    else
      render json: { msg: 'Already paid' }
    end
  end

  def history
    @history = Payment.where("(sender_id = ? OR recipient_id = ?) AND paid = ?", "#{current_user.id}", "#{current_user.id}", true )
    @history = @history.sort.reverse
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:title, :sender_id, :recipient_id, :amount, :type_id, :note)
    end
end
