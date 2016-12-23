wxssrn = require './index'

#ret = wxssrn.parseStyle 'width:1px', 1

#ret = wxssrn.parseStyle 'width:1px;color:#fff; font-style:italic;textAlign', 1

ret = wxssrn.parseStyle 'width:1px;', 1
console.log ret

