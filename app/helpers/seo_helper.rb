module SeoHelper
  def render_canonical
    request.protocol.to_s + request.env["SERVER_NAME"].to_s + request.path.to_s
  end

  def meta_title
    if @meta_title.present?
      @meta_title
    else
      "Find Concierge Doctors and Direct Primary Care Physicians Online | FindMyDirectDoctor"
    end
  end

  def meta_description
    if @meta_description.present?
      @meta_description
    else
      "Find the best direct primary care physicians and top concierge doctors online. FindMyDirectDoctor is the most comprehensive resource to find concierge doctors and direct primary care doctors in the US."
    end
  end

  def allow_crawler
    if controller_name == 'home'
      "INDEX, FOLLOW"
    else
      "NOINDEX, NOFOLLOW"
    end
  end

  def og_type
    if @article.present?
      "article"
    else
      "website"
    end
  end
end
