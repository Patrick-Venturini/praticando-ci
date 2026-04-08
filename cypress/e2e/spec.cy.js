describe('template spec', () => {
  it('passes', () => {
    cy.visit('http://localhost:3000/');

    cy.contains('Cadastro', { timeout: 10000 });
    cy.get('input[aria-label="Nome"]').type('Patrick')
    cy.get('input[aria-label="Email"]').type('email@teste.com')

    cy.contains('Cadastrar').click({ force: true })

    cy.contains('Patrick V')
      .should('be.visible')
      .and('contain.text', 'email@teste.com');
  });
})