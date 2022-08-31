cd %PROJECT_PATH%
REM venv\Scripts\activate.bat
git pull && ^
make parse && ^
make full-extract && ^
make ingest && ^
make data && ^
make validate && ^
make datapackage.json && ^
make test && ^
make build && ^
REM make update && ^
git add . && ^
git commit -m "Atualização age7" && ^
git push origin master
echo %errorlevel% > logs/exit-code.txt
git rev-parse --short HEAD > logs/commit.txt
make notify
