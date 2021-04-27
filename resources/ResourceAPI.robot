*** Settings ***
Documentation   Documentação da Fake Rest API
Library         RequestsLibrary
Library         Collections

*** Variables ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}      id=15
...             title=Book 15
...             pageCount=1500
&{BOOK_200}     id=200
...             title=Meu novo Book
...             description=Meu novo livro conta coisas fantásticas
...             pageCount=523
...             excerpt=Meu Novo livro é massa
...             publishDate=2018-04-26T17:58:14.765Z
&{BOOK_2323}    id=2323
...             title=teste2323
...             description=teste2323
...             pageCount=201
...             excerpt=teste2323
...             publishDate=2022-03-04T17:37:49.822Z

*** Keywords ***
Conectar a API
    Create Session      fakeAPI     ${URL_API}

Requisitar todos os livros
    ${RESPOSTA}             GET On Session     fakeAPI     Books
    # Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}             GET On Session     fakeAPI     Books/${ID_LIVRO}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}

Cadastrar um novo livro
    ${HEADERS}              Create Dictionary       content-type=application/json
    ${RESPOSTA}             POST On Session         fakeAPI     Books/
    ...                                             data={"id": ${BOOK_200.id},"Title": "${BOOK_200.Title}","Description": "${BOOK_200.Description}","PageCount": ${BOOK_200.PageCount},"Excerpt": "${BOOK_200.Excerpt}","PublishDate": "${BOOK_200.PublishDate}"}
    ...                                             headers=${HEADERS}
    Set Test Variable      ${RESPOSTA}
    Log                    ${RESPOSTA.text}
    Set Test Variable      ${RESPOSTA}

Alterar livro "${ID_LIVRO}"
    ${HEADERS}              Create Dictionary       content-type=application/json
    ${RESPOSTA}             PUT On Session          fakeAPI     Books/${ID_LIVRO}
    ...                                             data={"id": 2323,"title": "teste2323","description": "teste2323","pageCount": 201,"excerpt": "teste2323","publishDate": "2022-03-04T17:37:49.822Z"}
    ...                                             headers=${HEADERS}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}

Deletar livro "${ID_LIVRO}"
    ${RESPOSTA}             DELETE On Session     fakeAPI     Books/${ID_LIVRO}
    Log                     ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}

### CONFERÊNCIAS

Conferir o status code
    [Arguments]     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings       ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]     ${REASON_DESEJADO}
    Should Be Equal As Strings       ${RESPOSTA.reason}     ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be                    ${RESPOSTA.json()}      ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item      ${RESPOSTA.json()}      id              ${BOOK_15.id}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      title           ${BOOK_15.title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      pageCount       ${BOOK_15.pageCount}
    Should Not Be Empty                 ${RESPOSTA.json()["description"]}
    Should Not Be Empty                 ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                 ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir se retorna todos os dados alterados do livro "${ID_LIVRO}"
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]     ${ID_LIVRO}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      id              ${BOOK_${ID_LIVRO}.id}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      title           ${BOOK_${ID_LIVRO}.title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      description     ${BOOK_${ID_LIVRO}.description}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      pageCount       ${BOOK_${ID_LIVRO}.pageCount}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      excerpt         ${BOOK_${ID_LIVRO}.excerpt}
    Dictionary Should Contain Item      ${RESPOSTA.json()}      publishDate     ${BOOK_${ID_LIVRO}.publishDate}

Conferir se deleta o livro
    Should Be Empty                     ${RESPOSTA.content}
