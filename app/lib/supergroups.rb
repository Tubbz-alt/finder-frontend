class Supergroups
  def self.lookup(keys)
    return [] unless keys
    keys = [keys] if keys.is_a?(String)
    groups = GovukDocumentTypes.supergroups(ids: keys)
    groups.map { |g| Supergroup.new(g) }
  end
end

class Supergroup
  attr_reader :label, :value, :subgroups

  def initialize(hash)
    @value = hash["id"]
    @label = value.humanize
    @subgroups = hash["subgroups"]
  end

  def to_h
    {
      "label" => label,
      "value" => value,
      "subgroups" => subgroups_as_hash
    }
  end

  def subgroups_as_hash
    subgroups.map { |sg| { "label" => sg.humanize, "value" => sg } }
  end
end
