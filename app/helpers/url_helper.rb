module UrlHelper

  def build_url(link)
    uri = URI(request.original_url)
    "#{uri.scheme}://#{uri.host}/#{link}"
  end

end