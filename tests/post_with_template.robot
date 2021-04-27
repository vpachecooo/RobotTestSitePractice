*** Settings ***
Documentation       Exemplos da própria Library: https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.robot
...                 Doc da API do GitHub: https://developer.github.com/v3/
Library             RequestsLibrary
Library             Collections
Library             String
Resource            ./variables/my_user_and_passwords.robot

*** Variables ***
${GITHUB_HOST}      https://api.github.com
${ISSUES_URI}       /repos/mayribeirofernandes/myudemyrobotframeworkcourse/issues

*** Test Cases ***
Exemplo: Postando com body template
    Conectar com autenticação básica na API do GitHub
    Postar uma nova issue com label "robot framework"

*** Keywords ***
Conectar com autenticação básica na API do GitHub
    ${AUTH}             Create List           ${MY_GITHUB_USER}      ${MY_GITHUB_PASS}
    Create Session      alias=mygithubAuth    url=${GITHUB_HOST}     auth=${AUTH}     disable_warnings=True

Postar uma nova issue com label "${LABEL}"
    ${BODY}         Format String    ${CURDIR}/data/input/post_issue.json
    ...             user_git=${MY_GITHUB_USER}
    ...             label=${LABEL}
    Log             Meu Body ficou:\n${BODY}
    ${RESPONSE}     Post Request    alias=mygithubAuth    uri=${ISSUES_URI}   data=${BODY}
    Confere sucesso na requisição   ${RESPONSE}

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
