import ..index as _highlight

var highlight = _highlight.highlight()

def blade(text) {
  return highlight(text, 'blade')
}

describe('Blade script highlight test', @() {
  it('should higlight tokens in a block correctly!', @() {
    expect(blade('{ 10 }')).to_be('{ <span class="n">10</span> }')
    expect(blade('{ \'Hello World\' }')).to_be('{ <span class="s">\'Hello World\'</span> }')
    expect(blade('{\n  false\n}')).to_be('{\n  <span class="c">false</span>\n}')
  })

  it('should highlight expressions correctly!', @() {
    expect(blade('10 + 10')).to_be(
      '<span class="n">10</span> <span class="o">+</span> <span class="n">10</span>'
    )
    expect(blade('self.name = "".join([1, 2, 3])')).to_be(
      '<span class="c">self</span>.name <span class="o">=</span>' +
      ' <span class="s">""</span>.<span class="m">' +
      'join</span>([<span class="n">1</span>, <span class="n">2</span>,' +
      ' <span class="n">3</span>])'
    )

    # nested functions
    expect(blade('expect(call()).to_be(method())')).to_be(
      '<span class="f">expect</span>(<span class="f">call</span>()).' +
      '<span class="m">to_be</span>(<span class="f">' +
      'method</span>())'
    )
  })

  it('should highlight statements correctly!', @() {
    expect(blade('if x > 10 {\n' +
      'echo "It works!"\n' +
    '}')).to_be(
      '<span class="k">if</span> x &gt; <span class="n">10</span> {\n' +
      '<span class="k">echo</span> <span class="s">"It works!"</span>\n}'
    )
    expect(blade('using x {\n  when 1 return 0\n  when 2 {\n    return 3\n  }\n}')).to_be(
      '<span class="k">using</span> x {\n  <span class="k">when</span>' +
      ' <span class="n">1</span> <span class="k">return</span> ' +
      '<span class="n">0</span>\n  <span class="k">when</span> ' +
      '<span class="n">2</span> {\n    <span class="k">return</span> ' +
      '<span class="n">3</span>\n  }\n}'
    )
  })

  it('should higlight declarations correctly!', @() {
    expect(blade('var x')).to_be('<span class="k">var</span> x')
    expect(blade('var x = 20')).to_be(
      '<span class="k">var</span> x <span class="o">=</span> <span class="n">20</span>'
    )
    expect(blade('{ var x }')).to_be('{ <span class="k">var</span> x }')
  })

  it('should highlight whole scripts correctly!', @() {
    expect(blade(
      'def highlight_json(text, colors) {\n  return text.replace(\'/("(?:[^"\\\\]|\\.)*")/\', ' +
      '\'<span class="color:\${colors.operator}">$1</span>\')\n}'
    )).to_be(
      '<span class="k">def</span> <span class="f">highlight_json</span>' +
      '(text, colors) {\n  <span class="k">return</span> text.<span class="m">' +
      'replace</span>(<span class="s">\'/("(?:[^"\\\\]|\.)*")/\'</span>, ' +
      '<span class="s">\'&lt;span class="color:<span class="i">\${colors.operator}' +
      '</span>"&gt;$1&lt;/span&gt;\'</span>)\n}'
    )
  })
})
