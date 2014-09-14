require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FileParser do
  {
    'commands spanning multiple lines' => (
        "\t  \\seq{ABC}{\n" + 
        "\t  /2 /2 /4C2 /4C2 /2\n" + 
        "\t  /2 /2:2 (/4 /4C4):2\n" + 
        "\t  }\n" + 
        "\t  \\seq{DEF}{\n" + 
        "\t  /4 /4 mylabel}\n" + 
        "\n"),
    'commands on same line' => (
      "\\seq{ABC}{ /2 /4C2 }\\seq{DEF}{ /4C2 /4C2}\\starttempo{120}"
    ),
    'expressions, commands, and comments' => (
      "# This is a comment, everything after is fine!!!\n" + 
      "\\seq{ABC}{ /2 /4C2} \\seq{DEF}{ /4C2 /4C2}\n" +
      "# Another comment here\n" + 
      "\\starttempo{120}\n" + 
      "# Annnnd, the last word.\n"
    )
  }.each do |context_str,str|
    context context_str do
      it 'should parse as FileNode' do
        FILE_PARSER.should parse_as(str,FileNode)
      end
    end
  end
end
