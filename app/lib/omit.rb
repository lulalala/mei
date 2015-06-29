module Omit
  # @param total [Integer] total number of replies
  # @param n_recent_only [Integer] number of replies to show if omit occurs.
  # @param avoid_only_n_hidden [Integer] if after omit the omitted replies is less than or equal to this number, then do not omit the replies
  # @return [Boolean] whether omit should occur
  def self.omit?(total, n_recent_only, avoid_only_n_hidden = 0)
    if total - n_recent_only <= avoid_only_n_hidden
      return false
    elsif total > n_recent_only
      true
    else
      false
    end
  end
end
