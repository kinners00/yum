plan yum_tasks::security_cache(
  TargetSpec $targets,
  String $cache,
  String $security
) {

  # Cache and security update 
  run_task('yum_tasks::update_cache', $targets, cache => $cache)
  run_task('yum_tasks::security', $targets, security => $security)

  }
