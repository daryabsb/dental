const middleware = {}

middleware['app'] = require('..\\middleware\\app.js')
middleware['app'] = middleware['app'].default || middleware['app']

middleware['auth-BAK'] = require('..\\middleware\\auth-BAK.js')
middleware['auth-BAK'] = middleware['auth-BAK'].default || middleware['auth-BAK']

export default middleware
