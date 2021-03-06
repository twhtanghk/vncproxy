module.exports =
  bootstrap: (cb) ->
    process.on 'SIGHUP', sails.config.vncproxy.reload
    sails.config.vncproxy
      .start()
      .catch sails.log.error
    sails.config.beforeShutdown = (cb) ->
      sails.config.vncproxy.stop()
        .then ->
          cb()
        .catch cb
    cb()
