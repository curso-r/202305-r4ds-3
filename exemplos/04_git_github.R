usethis::git_sitrep()

library(usethis)

use_git_config(user.name = "caio", user.email = "email do caio")

git_default_branch_configure()

create_github_token()

gitcreds::gitcreds_set()

# install.packages("gh")
gh::gh_whoami()

create_from_github(
  "https://github.com/clente/aula04",
  "/home/teste/",
  open = FALSE # Só para ver o que a função faz
)
