module SpendingsHelper
  def spending_bootstrap_status(status)
    return :warning if status == :cancelled
    :neutral
  end
end
