# frozen_string_literal: true

require 'nokogiri'

module Lab10SerHelper
  ROOT_TRANS = 'some_transformer.xslt'

  def self.insert_xslt_line(data, transform: ROOT_TRANS)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XML::ProcessingInstruction.new(
      doc, 'xml-stylesheet', "type=\"text/xsl\" href=\"#{transform}\""
    )

    doc.root.add_previous_sibling(xslt)
    doc
  end

  def self.print_res(file)
    doc = Nokogiri::XML(file)
    xslt = Nokogiri::XSLT(File.read('public/some_transformer.xslt'))
    xslt.transform(doc)
  end
end
