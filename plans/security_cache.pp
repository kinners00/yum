plan yum::security_cache(
  TargetSpec $targets,
  String $cache,
  String $security
) {

  # Cache and security update 
  run_task('yum::update_cache', $targets, cache => $cache)
  run_task('yum::security', $targets, security => $security)

  }
