chalk = require('chalk')
LocalStrategy = require('passport-local').Strategy
TwitterStrategy = require('passport-twitter').Strategy
FacebookStrategy = require('passport-facebook').Strategy
GitHubStrategy = require('passport-github').Strategy
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
LinkedinStrategy = require('passport-linkedin').Strategy

module.exports = (passport, config) ->

  Bookshelf = require('bookshelf')
  User = Bookshelf.session.model('User')

  # serialize sessions
  passport.serializeUser (user, done) ->
    if !user.id
      throw new Exception 'Model has no id'
    done null, user.id
    return
  passport.deserializeUser (id, done) ->
    User.collection()
    .query(where: id: id).fetchOne().then((user) ->
      done null, user
      return
    ).catch (err) ->
      done err
      return
    return
  # use local strategy
  passport.use new LocalStrategy({
    usernameField: 'email'
    passwordField: 'password'
  }, (email, password, done) ->
    User.collection()
    .query(where: email: email).fetchOne()
    .then (user) ->
      if !user
        return done(null, false, message: 'Unknown user')
      if !user.authenticate(password)
        return done(null, false, message: 'Invalid password')
      done null, user
    return
  )
  if config.github
    # use github strategy
    passport.use new GitHubStrategy({
      clientID: config.github.clientID
      clientSecret: config.github.clientSecret
      callbackURL: config.github.callbackURL
    }, (accessToken, refreshToken, profile, done) ->

      User.collection()
      .query(where: github: profile.id).fetchOne()
      .then (user) ->
        if user
          done null, user
        else
          User.forge(
            name: profile.displayName
            email: profile.emails[0].value
            username: profile.username
            provider: 'github'
            github: profile.id).save().then(
            (user) ->
              done null, user
            ).catch(
            (err) ->
              console.log chalk.red(err)
              done err, user
            )

        return
      return
  )
  if config.twitter
    # use twitter strategy
    passport.use new TwitterStrategy({
      consumerKey: config.twitter.clientID
      consumerSecret: config.twitter.clientSecret
      callbackURL: config.twitter.callbackURL
    }, (token, tokenSecret, profile, done) ->
      User.collection()
      .query(where: twitter: profile.id).fetchOne()
      .then (user) ->
        if user
          return done(null, user)
        else
          user = User.forge(
            name: profile.displayName
            username: profile.username
            provider: 'twitter'
            twitter: profile.id).save().then(
            (user) ->
              done null, user
            ).catch(
            (err) ->
              console.log chalk.red(err)
              done err, user
            )
        return
      return
  )
  if config.facebook
    # use facebook strategy
    passport.use new FacebookStrategy({
      clientID: config.facebook.clientID
      clientSecret: config.facebook.clientSecret
      callbackURL: config.facebook.callbackURL
    }, (accessToken, refreshToken, profile, done) ->
      User.collection()
      .query(where: facebook: profile.id).fetchOne()
      .then (user) ->
        if user
          done null, user
        else
          User.forge(
            name: profile.displayName
            email: profile.emails[0].value
            username: profile.username
            provider: 'facebook'
            facebook: profile._json).save().then((user) ->
            done null, user
          ).catch (err) ->
            console.log chalk.red(err)
            done err, user
        return
      return
)
  if config.google
    # use google strategy
    passport.use new GoogleStrategy({
      clientID: config.google.clientID
      clientSecret: config.google.clientSecret
      callbackURL: config.google.callbackURL
    }, (accessToken, refreshToken, profile, done) ->
      User.collection()
      .query(where: google: profile.id).fetchOne()
      .then (user) ->
        if user
          return done(null, user)
        else
          user = User.forge(
            name: profile.displayName
            email: profile.emails[0].value
            username: profile.username
            provider: 'google'
            google: profile.id).save().then((user) ->
            done null, user
          ).catch((err) ->
            console.log chalk.red(err)
            done err, user
          )
        return
      return
  )
  if config.linkedin
    # use linkedin strategy
    passport.use new LinkedinStrategy({
      consumerKey: config.linkedin.clientID
      consumerSecret: config.linkedin.clientSecret
      callbackURL: config.linkedin.callbackURL
      profileFields: [
        'id'
        'first-name'
        'last-name'
        'email-address'
      ]
    }, (accessToken, refreshToken, profile, done) ->
      User.collection()
      .query(where: linkedin: profile.id).fetchOne()
      .then (user) ->
        if user
          done null, user
        else
          User.forge(
            name: profile.displayName
            email: profile.emails[0].value
            username: profile.emails[0].value
            provider: 'linkedin').save().then((user) ->
            done null, user
          ).catch (err) ->
            console.log chalk.red(err)
            done err, user
        return
      return
  )
  return
