require 'asciidoctor/extensions'

class ConseilBlock < Asciidoctor::Extensions::BlockProcessor
  use_dsl
  named :CONSEIL
  on_context :example

  def process parent, reader, attrs
    attrs['name'] = 'university'
    attrs['caption'] = 'Conseil'
    admon = create_block parent, :admonition, nil, attrs, content_model: :compound
    parse_content admon, reader
    admon
  end
end

class ConseilBlockCss < Asciidoctor::Extensions::DocinfoProcessor
  use_dsl

  def process doc
    '<style>
.admonitionblock td.icon .icon-university:before{content:"\f19c";color:#000}
</style>'
  end
end

Asciidoctor::Extensions.register do
  block ConseilBlock
  docinfo_processor ConseilBlockCss
end
