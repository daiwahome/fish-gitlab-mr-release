function __fish_gitlab_mr_release_needs_git_repository
  git status &> /dev/null
  test $status -ne 128
end

set -l commands create help init version

complete -c gitlab_mr_release -xa create \
  -n "__fish_use_subcommand" \
  -d 'Create merge request'
complete -c gitlab_mr_release -f \
  -n '__fish_seen_subcommand_from create'
complete -c gitlab_mr_release -s s -l source -xa "(git for-each-ref --format='%(refname:short)' refs/remotes/ | sed -e 's|^origin/||')" \
  -n '__fish_seen_subcommand_from create; and __fish_gitlab_mr_release_needs_git_repository' \
  -d 'Source branch (e.g. develop)'
complete -c gitlab_mr_release -s t -l target -xa "(git for-each-ref --format='%(refname:short)' refs/remotes/ | sed -e 's|^origin/||')" \
  -n '__fish_seen_subcommand_from create; and __fish_gitlab_mr_release_needs_git_repository' \
  -d 'Target branch (e.g. master)'
complete -c gitlab_mr_release -l title -x \
  -n '__fish_seen_subcommand_from create' \
  -d "MergeRequest title (default. 'Release :timestamp :source -> :target')"
complete -c gitlab_mr_release -s l -l labels -x \
  -n '__fish_seen_subcommand_from create' \
  -d "Labels for MR as a comma-separated list (e.g. 'label1,label2')"

complete -c gitlab_mr_release -xa help \
  -n "__fish_use_subcommand" \
  -d 'Describe available commands or one specific command'
complete -x -c gitlab_mr_release -xa "$commands" \
 -n '__fish_seen_subcommand_from help'

complete -c gitlab_mr_release -xa init \
  -n "__fish_use_subcommand" \
  -d 'Copy setting files to current directory'
complete -x -c gitlab_mr_release -x \
 -n '__fish_seen_subcommand_from init'

complete -c gitlab_mr_release -xa version \
  -n "__fish_use_subcommand" \
  -d 'Show gitlab_mr_release version'
complete -x -c gitlab_mr_release -x \
 -n '__fish_seen_subcommand_from version'

