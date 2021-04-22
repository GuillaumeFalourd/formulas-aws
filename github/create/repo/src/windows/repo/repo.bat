@echo off
SETLOCAL

call:%~1
goto exit

:run
  if "%RIT_WORKSPACE_PATH%" == " " (
    mkdir %CURRENT_PWD%\%RIT_PROJECT_NAME%
    cd %CURRENT_PWD%\%RIT_PROJECT_NAME%
    echo %RIT_PROJECT_DESCRIPTION% >> README.md
  ) else (
    cd %RIT_WORKSPACE_PATH%
  )

  git init
  git add .
  git commit -m "Initial Commit"

  curl -H "Authorization: token %RIT_GITHUB_TOKEN%" https://api.github.com/user/repos -d "{\"name\":\"%RIT_PROJECT_NAME%\", \"private\": %PRIVATE%}"
  git remote add origin https://%RIT_GITHUB_USER%:%RIT_GITHUB_TOKEN%@github.com/%RIT_GITHUB_USER%/%RIT_PROJECT_NAME%.git
  git push origin master

  echo Repository successfully initialized with git and added on Github!!

:exit
  ENDLOCAL
  exit /b
