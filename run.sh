cd $PROJECT_PATH
source venv/Scripts/activate
{
make update && \
git add . && git commit -m "Atualização age7"
} > logs/all.txt
echo $? > logs/exit-code.txt
git rev-parse --short HEAD > logs/commit.txt
make notify
git add logs/notify.Rout logs/all.txt && git commit -m "Atualização age7 - logs notificação"
git push origin main
