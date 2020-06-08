# Perform cache refresh/clean and then installs chosen package.

# cache params: update/clean
# security params: minimal/full
# targets params: targets to run plan on

plan yum_tasks::package_cache(
  TargetSpec $targets,
  String $cache,
  String $package
) {

  run_task('yum_tasks::update_cache', $targets, cache => $cache)
  run_task('yum_tasks::install', $targets, package => $package)

  }
