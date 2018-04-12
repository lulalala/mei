# frozen_string_literal: true

# Serializing board config column.
#
# Any blank inputs will be converted to empty hash
class BoardConfigSerializer
  def self.load(i)
    if i.blank?
      {}
    else
      YAML.safe_load(i)
    end
  end

  def self.dump(i)
    i = {} if i.blank?

    if i.is_a?(String) # Allow assigning an YAML string as input
      i
    else
      YAML.dump(i)
    end
  end
end
