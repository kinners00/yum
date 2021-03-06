# Perform cache refresh/clean and then run security update
plan yum_tasks::security_cache(
  TargetSpec $targets,
  Enum['clean','update'] $cache = undef,
  Enum['minimal','full'] $security = undef,
) {

  run_task('yum_tasks::update_cache', $targets, cache => $cache,)
  run_task('yum_tasks::security', $targets, security => $security, '_run_as' => 'root')

  }
