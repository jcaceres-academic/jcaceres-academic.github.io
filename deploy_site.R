# deploy_site.R
quarto::quarto_render()
system("cp -r _site/* .")
system('git add .')
system('git commit -m "Auto-deploy Quarto site"')
system('git push origin main --force')
