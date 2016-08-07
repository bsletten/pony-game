use "logger"

class Game
  let _env: Env
  
  var _config: GameConfig
  var _logger: Logger[String]
  var _clock: GameClock
  
  new create(env: Env) =>
    _env = env
    
    _config = GameConfig(env)
    _logger = StringLogger(Fine, env.out)
    _clock = GameClock
    
  fun ref init(): Bool =>
    // Read config.
    _config.parse("ponygame.ini")
    
    // Get log level.
    var log_level: LogLevel = Fine
    var config_log_level: String = _config("LogLevel")
    
    if config_log_level == "Info" then
      log_level = Info
    elseif config_log_level == "Warn" then
      log_level = Warn
    elseif config_log_level == "Error" then
      log_level = Error
    else
      config_log_level = "Fine"
    end
    
    // Initialize logger.
    _logger = StringLogger(log_level, _env.out)
    _logger.log("Log Level: " + config_log_level)
    
  fun config(): this->GameConfig =>
    _config
    
  fun logger(): this->Logger[String] =>
    _logger
    
  fun clock(): this->GameClock =>
    _clock