class RedirectConstraint
  def matches?(request)
    PageRedirect.find_by(old: request.path).present?
  end
end
