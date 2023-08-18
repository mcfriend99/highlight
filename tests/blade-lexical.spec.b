import ..index as _highlight

var highlight = _highlight.highlight()

def blade(text) {
  return highlight(text, 'blade')
}

describe('Blade lexical highlight test', @() {
  it('should highlight string tokens correctly!', @() {
    expect(blade("'Hello, World'")).to_be('<span class="s">\'Hello, World\'</span>')
    expect(blade('"Hello, World"')).to_be('<span class="s">"Hello, World"</span>')
  })

  it('should highlight escaped string tokens correctly!', @() {
    expect(blade('"\\"that\'s\\" it"')).to_be('<span class="s">"\\"that\'s\\" it"</span>')
  })

  it('should highlight interpolation tokens correctly!', @() {
    expect(blade("'\${name}'")).to_be('<span class="s">\'<span class="i">\${name}</span>\'</span>')
  })

  it('should highlight constant tokens correctly!', @() {
    expect(blade('nil')).to_be('<span class="c">nil</span>')
    expect(blade('true')).to_be('<span class="c">true</span>')
    expect(blade('false')).to_be('<span class="c">false</span>')
    expect(blade('parent')).to_be('<span class="c">parent</span>')
    expect(blade('self')).to_be('<span class="c">self</span>')
    expect(blade('self.test')).to_be('<span class="c">self</span>.test')
  })

  it('should highlight numeric tokens correctly!', @() {
    expect(blade('15')).to_be('<span class="n">15</span>')
    expect(blade('15.25')).to_be('<span class="n">15.25</span>')
    expect(blade('-15.25')).to_be('<span class="o">-</span><span class="n">15.25</span>')
    expect(blade('0xacd')).to_be('<span class="n">0xacd</span>')
    expect(blade('0xACD')).to_be('<span class="n">0xACD</span>')
    expect(blade('0xACDG')).to_be('<span class="n">0xACD</span>G')
    expect(blade('0c644')).to_be('<span class="n">0c644</span>')
    expect(blade('0c6448')).to_be('<span class="n">0c644</span><span class="n">8</span>')
    expect(blade('0b10010')).to_be('<span class="n">0b10010</span>')
    expect(blade('33.413E-10')).to_be(
      '<span class="n">33.413</span>E<span class="o">-</span><span class="n">10</span>'
    )
  })

  it('should highlight function and method tokens correctly!', @() {
    expect(blade('method\()')).to_be('method\()')
    expect(blade('method()')).to_be('<span class="f">method</span>()')
    expect(blade('x.method()')).to_be('x.<span class="m">method</span>()')
    expect(blade('x.method.()')).to_be('x.method.()')
    expect(blade('1method()')).to_be('<span class="n">1</span><span class="f">method</span>()')
  })

  it('should highlight operator tokens correctly!', @() {
    expect(blade('+')).to_be('<span class="o">+</span>')
    expect(blade('-')).to_be('<span class="o">-</span>')
    expect(blade('*')).to_be('<span class="o">*</span>')
    expect(blade('/')).to_be('<span class="o">/</span>')
    expect(blade('~')).to_be('<span class="o">~</span>')
    expect(blade('^')).to_be('<span class="o">^</span>')
    expect(blade('!')).to_be('<span class="o">!</span>')
    expect(blade('=')).to_be('<span class="o">=</span>')
    expect(blade('@')).to_be('<span class="o">@</span>')

    # compound operators
    expect(blade('..')).to_be('<span class="o">..</span>')
    expect(blade('and')).to_be('<span class="o">and</span>')
    expect(blade('or')).to_be('<span class="o">or</span>')

    expect(blade('&')).to_be('&')
    expect(blade('|')).to_be('|')
    expect(blade('>')).to_be('&gt;')
    expect(blade('<')).to_be('&lt;')

    # * and / should only be highlighted as operators when not used together with one another.
    expect(blade('/*')).to_be('/*')
    expect(blade('*/')).to_be('*/')

    # range operator should be not be highligthed if there's a space between the two dots.
    expect(blade('. .')).to_be('. .')
  })

  it('should highlight keyword tokens correctly!', @() {
    expect(blade('as')).to_be('<span class="k">as</span>')
    expect(blade('assert')).to_be('<span class="k">assert</span>')
    expect(blade('break')).to_be('<span class="k">break</span>')
    expect(blade('catch')).to_be('<span class="k">catch</span>')
    expect(blade('class')).to_be('<span class="k">class</span>')
    expect(blade('continue')).to_be('<span class="k">continue</span>')

    expect(blade('def')).to_be('<span class="k">def</span>')
    expect(blade('default')).to_be('<span class="k">default</span>')
    expect(blade('die')).to_be('<span class="k">die</span>')
    expect(blade('do')).to_be('<span class="k">do</span>')
    expect(blade('echo')).to_be('<span class="k">echo</span>')
    expect(blade('else')).to_be('<span class="k">else</span>')
    expect(blade('finally')).to_be('<span class="k">finally</span>')
    expect(blade('for')).to_be('<span class="k">for</span>')

    expect(blade('if')).to_be('<span class="k">if</span>')
    expect(blade('import')).to_be('<span class="k">import</span>')
    expect(blade('in')).to_be('<span class="k">in</span>')
    expect(blade('iter')).to_be('<span class="k">iter</span>')
    expect(blade('return')).to_be('<span class="k">return</span>')
    expect(blade('static')).to_be('<span class="k">static</span>')
    expect(blade('try')).to_be('<span class="k">try</span>')

    expect(blade('using')).to_be('<span class="k">using</span>')
    expect(blade('var')).to_be('<span class="k">var</span>')
    expect(blade('when')).to_be('<span class="k">when</span>')
    expect(blade('while')).to_be('<span class="k">while</span>')
  })

  it('should highlight comment tokens correctly!', @() {
    expect(blade('# some useful comment')).to_be('<span class="c"># some useful comment</span>')
    expect(blade('/* some useful comment */')).to_be('<span class="c">/* some useful comment */</span>')

    expect(blade('/*\n    some useful comment \n    */')).to_be('<span class="c">/*\n    some useful comment \n    */</span>')
  })

  it('should highlight nested comments correctly!', @() {
    # single line nested in block comment.
    expect(blade('/*\n    # some useful comment \n    */')).to_be('<span class="c">/*\n    # some useful comment \n    */</span>')

    # block nested in single line comment
    expect(blade('# some /* useful */ comment')).to_be('<span class="c"># some /* useful */ comment</span>')

    # block nested in block comment
    expect(blade('/*\n    something inside \n    /* something inside */ '+
      '\n    something inside \n    */ something outside /*something inside */')).
      to_be('<span class="c">/*\n    something inside \n    /* something inside */ \n    '+
      'something inside \n    */</span> something outside <span class="c">/*something inside */</span>')
  })
})
