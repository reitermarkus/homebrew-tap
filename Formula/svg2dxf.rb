class Svg2dxf < Formula
  desc "Converts SVG graphics to DXF"
  homepage "https://blog.willwinder.com/2014/02/easy-and-accurate-svg-to-dxf-conversion.html"
  license "MIT"
  head "https://github.com/winder/svgToDxf.git"

  depends_on "pstoedit"

  def install
    bin.install "svgToDxf.sh" => "svg2dxf"
  end
end
