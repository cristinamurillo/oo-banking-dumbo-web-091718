require 'pry'

class Transfer

  attr_reader :sender, :receiver, :amount
  attr_writer
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status == "pending" && @sender.valid? && @amount <= @sender.balance
      @sender.balance-= @amount
      @receiver.balance+= @amount
      @status= "complete"
    elsif @status == "pending"
      @status= "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance+= @amount
      @receiver.balance-= @amount
      @status= "reversed"
    end 
  end

end
