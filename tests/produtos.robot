*** Settings ***
Resource            ../resources/Global.robot
Test Setup          Preparar Suite  
Test Teardown       Teminar Suite

*** Variables ***

*** Test Cases ***
CT001 - Pesquisar Produtos Existentes
    [Documentation]     Este cenário deve Pesquisar Produtos Existentes
    [Tags]              CT001
    Given que estou na página home do site
    When eu pesquisar pelo produto "Blouse"
    Then o produto "Blouse" deve ser listado na página de resultado da busca

CT002 - Pesquisar Produtos não Existentes
    [Documentation]     Este cenário deve Pesquisar Produtos não Existentes
    [Tags]              CT002
    Given que estou na página home do site
    When eu pesquisar pelo produto "produtoNãoExistente"
    Then a página deve exibir a mensagem "No results were found for your search "produtoNãoExistente""

CT003 - Listar Produtos
    [Documentation]     Este cenário deve Listar Produtos
    [Tags]              CT003
    Given que estou na página home do site
    When eu passar o mouse sobre o menu "Women"
    And selecione a categoria "Summer Dresses"
    Then deve exibir uma página com os produtos da categoria selecionada

CT004 - Adicionar Produtos no Carrinho
    [Documentation]     Este cenário deve adicionar produtos ao carrinho
    [Tags]              CT004
    Given que estou na página home do site
    When eu pesquisar pelo produto "t-shirt"
    And clicar no botão "Add to cart" do produto listado
    And clicar no botão "Proceed to checkout"
    Then deve exibir a tela do carrinho com o produto "Faded Short Sleeve T-shirts" e preço "$16.51"

CT005 - Remover Produtos
    [Documentation]     Este cenário deve remover produtos do carrinho de compras
    [Tags]              CT005
    Given que estou na página home do site
    And adiciono um produto ao carrinho de compras
    And clicar no ícone do carrinho de compras
    When clicar no botão de remoção de um produto
    Then deve apresentar a mensagem "Your shopping cart is empty."

*** Keywords ***
And adiciono um produto ao carrinho de compras
    Given que estou na página home do site
    When eu pesquisar pelo produto "t-shirt"
    And clicar no botão "Add to cart" do produto listado
    And clicar no botão "Proceed to checkout"
    Then deve exibir a tela do carrinho com o produto "Faded Short Sleeve T-shirts" e preço "$16.51"