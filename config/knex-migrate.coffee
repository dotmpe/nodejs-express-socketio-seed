module.exports = (envname) ->
  (
    development: require('./config') .development.database.main
  )[envname]


