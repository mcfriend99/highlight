import ..index as _highlight

var highlight = _highlight.highlight()

def blade(text) {
  return highlight(text, 'blade')
}

describe('Blade script highlight test', @() {
  it('should higlight tokens in a block correctly!', @() {
    expect(blade('{ 10 }')).to_be('{ <span style="color:#905">10</span> }')
    expect(blade('{ \'Hello World\' }')).to_be('{ <span style="color:#690">\'Hello World\'</span> }')
    expect(blade('{\n  false\n}')).to_be('{\n  <span style="color:#ff9800">false</span>\n}')
  })

  it('should highlight expressions correctly!', @() {
    expect(blade('10 + 10')).to_be(
      '<span style="color:#905">10</span> <span style="color:#9a6e3a">+</span> <span style="color:#905">10</span>'
    )
    expect(blade('self.name = "".join([1, 2, 3])')).to_be(
      '<span style="color:#ff9800">self</span>.name <span style="color:#9a6e3a">=</span>' +
      ' <span style="color:#690">""</span>.<span style="color:#ff5722;font-style:italic">' +
      'join</span>([<span style="color:#905">1</span>, <span style="color:#905">2</span>,' +
      ' <span style="color:#905">3</span>])'
    )

    # nested functions
    expect(blade('expect(call()).to_be(method())')).to_be(
      '<span style="color:#ff5722">expect</span>(<span style="color:#ff5722">call</span>()).' +
      '<span style="color:#ff5722;font-style:italic">to_be</span>(<span style="color:#ff5722">' +
      'method</span>())'
    )
  })

  it('should highlight statements correctly!', @() {
    expect(blade('if x > 10 {\n' +
      'echo "It works!"\n' +
    '}')).to_be(
      '<span style="color:#2196f3">if</span> x &gt; <span style="color:#905">10</span> {\n' +
      '<span style="color:#2196f3">echo</span> <span style="color:#690">"It works!"</span>\n}'
    )
    expect(blade('using x {\n  when 1 return 0\n  when 2 {\n    return 3\n  }\n}')).to_be(
      '<span style="color:#2196f3">using</span> x {\n  <span style="color:#2196f3">when</span>' +
      ' <span style="color:#905">1</span> <span style="color:#2196f3">return</span> ' +
      '<span style="color:#905">0</span>\n  <span style="color:#2196f3">when</span> ' +
      '<span style="color:#905">2</span> {\n    <span style="color:#2196f3">return</span> ' +
      '<span style="color:#905">3</span>\n  }\n}'
    )
  })

  it('should higlight declarations correctly!', @() {
    expect(blade('var x')).to_be('<span style="color:#2196f3">var</span> x')
    expect(blade('var x = 20')).to_be(
      '<span style="color:#2196f3">var</span> x <span style="color:#9a6e3a">=</span> <span style="color:#905">20</span>'
    )
    expect(blade('{ var x }')).to_be('{ <span style="color:#2196f3">var</span> x }')
  })

  it('should highlight whole scripts correctly!', @() {
    expect(blade(
      'def highlight_json(text, colors) {\n  return text.replace(\'/("(?:[^"\\\\]|\\.)*")/\', ' +
      '\'<span style="color:\${colors.operator}">$1</span>\')\n}'
    )).to_be(
      '<span style="color:#2196f3">def</span> <span style="color:#ff5722">highlight_json</span>' +
      '(text, colors) {\n  <span style="color:#2196f3">return</span> text.<span style="color:#ff5722;' +
      'font-style:italic">replace</span>(<span style="color:#690">\'/("(?:[^"\\\\]|\.)*")/\'</span>, ' +
      '<span style="color:#690">\'&lt;span style="color:<span style="color:#00bcd4">\${colors.operator}' +
      '</span>"&gt;$1&lt;/span&gt;\'</span>)\n}'
    )
  })
})
