# Perform cache refresh/clean and then run security update.

# cache params: update/clean
# security params: minimal/full
# targets params: targets to run plan on

plan yum_tasks::security_cache(
  TargetSpec $targets,
  String $cache,
  String $security
) {

  run_task('yum_tasks::update_cache', $targets, cache => $cache)
  run_task('yum_tasks::security', $targets, security => $security)

  }
