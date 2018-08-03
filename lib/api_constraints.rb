class ApiConstraints
  include ActiveModel::Validations
  attr_reader :version

  validates :version,
      presence: true,
      allow_nil: false,
      numericality: { greater_than: 0 }

  def initialize(version:)
    @version = version

    # Prevent invalid version numbers in routes
    raise ArgumentError.new(errors.full_messages) unless valid?
  end

  def matches?(request)
    return false if request.headers['Accept'].blank?

    request.headers['Accept'].include?("application/vnd.store2be.api.v#{ @version }+json")
  end
end
