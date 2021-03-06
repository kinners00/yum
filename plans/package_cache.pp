# Perform cache refresh/clean and then installs chosen package.
plan yum_tasks::package_cache(
  TargetSpec $targets,
  Enum['clean','update'] $cache = undef,
  String $package
) {

  run_task('yum_tasks::update_cache', $targets, cache => $cache)
  run_task('yum_tasks::install', $targets, package => $package)

  }
