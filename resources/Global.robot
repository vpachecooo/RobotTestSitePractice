*** Settings ***
Library             SeleniumLibrary

*** Variables ***
${url}          http://automationpractice.com/
${browser}      chrome
# ${CT001}        CT001-Pesquisar_Produtos_Existentes.png

*** Keywords ***
### Setup e Teardown
Preparar Suite  
    Open Browser                       about:blank      ${browser}
    # Maximize Browser Window

Teminar Suite
    # Capture Page Screenshot
    Close Browser

### Passo a passo
###CT001
Given que estou na página home do site
    Go To                       ${url}
    Title Should Be             My Store   

When eu pesquisar pelo produto "${PRODUTO}"
    Input Text                  id:search_query_top     ${PRODUTO}
    Click Element               submit_search

Then o produto "${PRODUTO}" deve ser listado na página de resultado da busca
    # Page Should Contain Element         xpath://*[@class='product-container']
    # Page Should Contain Image           xpath://*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']
    Page Should Contain Element         xpath://*[@id="center_column"]//a[contains(text(),"${PRODUTO}")]

###CT002
Then a página deve exibir a mensagem "${expeted_message}"
    # ${message}=         Get WebElement         class:alert-warning
    # Should Be Equal     ${message.text}     ${expeted_message}
    Element Text Should Be      //*[@id="center_column"]/p[@class="alert alert-warning"]        ${expeted_message}

##CT003
When eu passar o mouse sobre o menu "Women"
    Mouse Over      xpath://*[@id="block_top_menu"]//a[@title='Women']

And selecione a categoria "Summer Dresses"
    Wait Until Element Is Visible       xpath://*[@id="block_top_menu"]//a[@title="Summer Dresses"]
    Click Link      Summer Dresses

Then deve exibir uma página com os produtos da categoria selecionada
    Title Should Be     Summer Dresses - My Store

###CT004
And clicar no botão "${CART}" do produto listado
    Scroll Element Into View        xpath://*[@id="center_column"]//a[1][@title='${CART}']
    # Wait Until Element Is Visible    xpath://*[@id="center_column"]//a[1][@title='${CART}']
    Click Link                       xpath://*[@id="center_column"]//a[1][@title='${CART}']

And clicar no botão "${CHECKOUT}"
    Wait Until Element Is Visible    xpath://*[@id="layer_cart"]//a[@title='${CHECKOUT}']
    Click Link                       xpath://*[@id="layer_cart"]//a[@title='${CHECKOUT}']

Then deve exibir a tela do carrinho com o produto "${PRODUTO}" e preço "${VALOR}"
    Wait Until Element Is Visible       id:product_1_1_0_0
    ${elemento}=        Get WebElement      id:product_1_1_0_0
    Should Contain      ${elemento.text}        ${PRODUTO}       
    Should Contain      ${elemento.text}        ${VALOR}

###CT005
And clicar no ícone do carrinho de compras
    Click Link      xpath://*[@id="header"]/div[3]//a[@title='View my shopping cart']
    # Click Link      xpath://*[@id="header"]//a[@title="View my shopping cart"]

When clicar no botão de remoção de um produto
    Click Link      id:1_1_0_0

Then deve apresentar a mensagem "${expeted_message}"
    ${message}=         Get WebElement          xpath://*[@id="center_column"]/p
    Should Be Equal     ${message.text}         ${expeted_message}