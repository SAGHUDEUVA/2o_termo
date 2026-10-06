const readline = require('readline-sync');
const fs = require('fs');
const ferramentas = [];
const total = readline.questionInt('Quantas ferramentas deseja registrar? ');

for (let i = 0; i < total; i++) {
  console.log(`\n--- Ferramenta ${i + 1} de ${total} ---`);
  const nome = readline.question('Nome: ');
  const quantidade = readline.questionInt('Quantidade (inteiro): ');
  const custoUnitario = readline.questionFloat('Custo Unitario (float): ');

  ferramentas.push({
    nome: nome,
    quantidade: quantidade,
    custoUnitario: custoUnitario
  });
}
try {
  fs.writeFileSync('ferramentas.json', JSON.stringify(ferramentas, null, 2), 'utf-8');

  console.log(`\n[Sucesso] Lote consolidado com ${ferramentas.length} itens guardados em "ferramentas.json".`);
} catch (erro) {
  console.error('\n[Erro] Não foi possível salvar o arquivo:', erro.message);
}
