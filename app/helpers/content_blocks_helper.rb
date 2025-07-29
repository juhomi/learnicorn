module ContentBlocksHelper
  def content_block_type_color(block_type)
    case block_type.to_s
    when "text"
      "primary"
    when "image"
      "success"
    when "video"
      "warning"
    else
      "secondary"
    end
  end

  def youtube_embed_url(url)
    # Convert YouTube URLs to embed format
    if url.include?("youtube.com/watch?v=")
      video_id = url.split("v=")[1].split("&")[0]
      "https://www.youtube.com/embed/#{video_id}"
    elsif url.include?("youtu.be/")
      video_id = url.split("youtu.be/")[1].split("?")[0]
      "https://www.youtube.com/embed/#{video_id}"
    else
      url
    end
  end

  def vimeo_embed_url(url)
    # Convert Vimeo URLs to embed format
    if url.include?("vimeo.com/")
      video_id = url.split("vimeo.com/")[1].split("/")[0]
      "https://player.vimeo.com/video/#{video_id}"
    else
      url
    end
  end
end
