# coffeelint: disable=max_line_length

module.exports = ( config ) ->
  development:
    facebook: null
    #  clientID: 'APP_ID'
    #  clientSecret: 'APP_SECRET'
    #  callbackURL: config.urls.base+'/auth/facebook/callback'
    twitter:
      clientID: 'BCjQ9SYFA5Ug55Nf0t4NJ0m0u'
      clientSecret: 'q0bnSIima5hi61hU9YlmgpBvr1CYz4LETfhfkEdMhSIP9s0kzD'
      callbackURL: config.development.urls.base+'/auth/twitter/callback'
    github:
      clientID: '18cbfb56550549f9dcef'
      clientSecret: 'c85adc2c361c20d2a3231fb1ee1637e369e59e3d'
      callbackURL: config.development.urls.base+'/auth/github/callback'
    google:
      clientID: '1036999515151-nfai47fvss3u9vt8uq94bt9fl958013i.apps.googleusercontent.com'
      clientSecret: 'yISHvY5_cO1OCANzWO-zdckV'
      callbackURL: config.development.urls.base+'/auth/google/callback'
    linkedin: null
    #  clientID: 'CONSUMER_KEY'
    #  clientSecret: 'CONSUMER_SECRET'
    #  callbackURL: config.urls.base+'/auth/linkedin/callback'

# coffeelint: enable=max_line_length
