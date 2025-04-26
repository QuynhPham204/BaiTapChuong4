*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                 https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}            Admin
${PASSWORD}            admin123
${INVALID_USERNAME}    Admi
${INVALID_PASSWORD}    admin12

*** Test Cases ***
Login Valid
    [Documentation]    Đăng nhập đúng username và password
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=5
    Input Text    xpath=//input[@name="username"]    ${USERNAME}
    Input Text    xpath=//input[@name="password"]    ${PASSWORD}
    Wait Until Element Is Enabled    xpath=//button[@type="submit"]    timeout=5
    TRY
        Click Element    xpath=//button[@type="submit"]  
    EXCEPT
        Log To Console    Không tìm thấy button login
    END
    Wait Until Element Is Visible    xpath=//p[@class="oxd-userdropdown-name"]    timeout=5
    ${user_name}=    Get Text    xpath=//p[@class="oxd-userdropdown-name"]
    Page Should Contain    ${user_name}
    Log To Console    Login thành công với user: ${user_name}
    Close Browser

Login Invalid - Sai cả username và password
    [Documentation]    Đăng nhập sai username và password
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=5
    Input Text    xpath=//input[@name="username"]    ${INVALID_USERNAME}
    Input Text    xpath=//input[@name="password"]    ${INVALID_PASSWORD}
    Wait Until Element Is Enabled    xpath=//button[@type="submit"]    timeout=5
    TRY
        Click Element    xpath=//button[@type="submit"]  
    EXCEPT
        Log To Console    Không tìm thấy button login
    END
    Page Should Contain    Invalid credentials
    Log To Console    Login không thành công 
    Close Browser

Login Invalid - Sai username, đúng password
    [Documentation]    Đăng nhập sai username nhưng đúng password
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=5
    Input Text    xpath=//input[@name="username"]    ${INVALID_USERNAME}
    Input Text    xpath=//input[@name="password"]    ${PASSWORD}
    Wait Until Element Is Enabled    xpath=//button[@type="submit"]    timeout=5
    TRY
        Click Element    xpath=//button[@type="submit"]  
    EXCEPT
        Log To Console    Không tìm thấy button login
    END
    Page Should Contain    Invalid credentials
    Log To Console    Login không thành công 
    Close Browser

Login Invalid - Đúng username, sai password
    [Documentation]    Đăng nhập đúng username nhưng sai password
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=5
    Input Text    xpath=//input[@name="username"]    ${USERNAME}
    Input Text    xpath=//input[@name="password"]    ${INVALID_PASSWORD}
    Wait Until Element Is Enabled    xpath=//button[@type="submit"]    timeout=5
    TRY
        Click Element    xpath=//button[@type="submit"]  
    EXCEPT
        Log To Console    Không tìm thấy button login
    END
    Page Should Contain    Invalid credentials
    Log To Console    Login không thành công 
    Close Browser

*** Keywords ***