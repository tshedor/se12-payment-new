class PaymentsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @sender_payments = Payment.where(sender_id: "#{current_user.id}", paid: false).all
    @recipient_payments = Payment.where(recipient_id: "#{current_user.id}", paid: false).all

    dollars_owed = 0
    Payment.where(recipient_id: "#{current_user.id}", paid: false).each do |p|
      dollars_owed += p.amount
    end

    dollars_due = 0
    Payment.where(sender_id: "#{current_user.id}", paid: false).each do |p|
      dollars_due += p.amount
    end

    @net_total = (dollars_owed - dollars_due)
  end


  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find_by_id(params[:id])
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

    if @payment.save
      redirect_to payments_path
      flash[:success] = "Payment created successfully!"
    else
      flash.now[:error] = @payment.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def paid
    payment = Payment.find(params[:id])
    unless payment.paid?
      payment.update_attribute(:paid, true)
      render json: { msg: true }
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
