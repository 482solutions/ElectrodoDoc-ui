import {Given, When, Then} from 'cypress-cucumber-preprocessor/steps';

before(() => {
    cy.registerUser();
})

Given(/^The user double click this folder "([^"]*)"$/,  (folder) => {
    cy.contains(folder).dblclick()
});

Then(/^The user is located in his created folder "([^"]*)"$/, (folderName) => {
    cy.get('.currentFolder')
        .should('be.visible')
        .should('contain.text', folderName)
});

When(/^User click Home button$/, () => {
    cy.get('.goHome').click().wait(1000)
});
