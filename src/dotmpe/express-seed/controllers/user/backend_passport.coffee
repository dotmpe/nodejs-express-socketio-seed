_ = require 'lodash'

module.exports = ( passport, config )->

	passport = passport || require 'passport'
	config = config || getDefaultConfig()

	_.merge config, url:
		login: '/login'

	passport: passport

	local: auth: passport.authenticate 'local',
		failureRedirect: config.url.login
		failureFlash: 'Invalid email or password.'

	facebook: 
		auth: passport.authenticate 'facebook',
			scope: [ 'email', 'user_about_me']
			failureRedirect: config.url.login
		cb: passport.authenticate 'facebook',
			failureRedirect: config.url.login

	github: 
		auth: passport.authenticate 'github',
			failureRedirect: config.url.login

	twitter: 
		auth: passport.authenticate 'twitter',
			failureRedirect: config.url.login

	google:
		auth: passport.authenticate 'google',
			failureRedirect: config.url.login
			scope: [
				'https://www.googleapis.com/auth/userinfo.profile',
				'https://www.googleapis.com/auth/userinfo.email'
			]
		cb: passport.authenticate 'google',
			failureRedirect: config.url.login

	linkedin:
		auth: passport.authenticate 'linkedin',
			failureRedirect: config.url.login
			scope: [
				'r_emailaddress'
			]
		cb: passport.authenticate 'linkedin',
			failureRedirect: config.url.login



