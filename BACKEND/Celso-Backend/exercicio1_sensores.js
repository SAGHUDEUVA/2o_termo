const fs = require('fs');

const sensores = [
  { codigo: 1001, tipo: "Temperatura", leituraAtual: 85.4, status: "Operando" },
  { codigo: 1002, tipo: "Pressão", leituraAtual: 6.2, status: "Operando" },
  { codigo: 1003, tipo: "Temperatura", leituraAtual: 102.7, status: "Alerta" }
];

const dadosJSON = JSON.stringify(sensores, null, 2);
fs.writeFileSync('sensores.json', dadosJSON);

console.log("Arquivo 'sensores.json' gerado com sucesso.");
