*** Settings ***
Documentation   Documentação da Fake Rest API
Resource        C:/Projetos/TestSitePractice/ResourceAPI.robot
Suite Setup     Conectar a API

*** Test Cases ***
Buscar listagem de todos os livros
    [Tags]      Buscar_Todos
    Requisitar todos os livros
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se retorna uma lista com "200" livros

Buscar um livro específico (GET em um livro específico)
    [Tags]      Buscar_ID
    Requisitar o livro "15"
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se retorna todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
    [Tags]      Cadastrar
    Cadastrar um novo livro
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se retorna todos os dados cadastrados do livro "200"

Alterar um livro (PUT)
    [Tags]      Alterar
    Alterar livro "2323"
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se retorna todos os dados alterados do livro "2323"

Deletar um livro (DELETE)
    [Tags]      Delete
    Deletar livro "2323"
    Conferir o status code      200
    Conferir o reason       OK
    Conferir se deleta o livro