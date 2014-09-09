require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CommentParser do
  context 'string starts with #' do
    it 'should parse' do
      [ "#",
        "# Hello world",
        "# This can be anything at all :)"
      ].each do |str|
        COMMENT_PARSER.should parse(str)
      end
    end
  end
end
