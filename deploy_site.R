# ================================================================
# Automated deployment script for Quarto site to GitHub Pages
# Author: Jesús Cáceres Tello
# Repository: jcaceres-academic.github.io
# ================================================================

# 1. Render the Quarto site
cat("▶ Rendering site with Quarto...\n")
quarto::quarto_render()

# 2. Clean previous root-level files (except project and source files)
cat("▶ Cleaning old deployment files...\n")
keep <- c("_site", ".git", ".gitignore", "_quarto.yml", "index.qmd", "styles.css", "images", ".Rproj.user", ".Rhistory", "*.Rproj")
unlink(list.files(".", all.files = TRUE, full.names = TRUE, no.. = TRUE)[
  !grepl(paste(keep, collapse="|"), list.files(".", all.files = TRUE))
], recursive = TRUE, force = TRUE)

# 3. Copy new files from _site to root
cat("▶ Copying new site from _site to root...\n")
system("cp -r _site/* .")

# 4. Commit and push to GitHub
cat("▶ Committing and pushing to GitHub...\n")
system('git add .')
system('git commit -m "Auto-deploy Quarto site to root"')
system('git push origin main --force')

cat("\n✅ Deployment complete! Your site should be live at:\n")
cat("https://jcaceres-academic.github.io\n")
