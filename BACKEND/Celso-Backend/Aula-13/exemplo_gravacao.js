const fs = require('fs');

console.log("====SISTEMA DE PERSISTÊNCIA: REGISTRO DE MÁQUINAS====");
const maquinasIndustriais = [

    {id:101, nome: "Torno Mecanico Universal", setor: "Usinagem", operacional: true},
    {id:102, nome: "Fresadora Ferramentaria", setor: "Usinagem", operacional: false},
    {id:103, nome: "Prensa Hidraulica 50T", setor: "Estampagem", operacional: true}
]
const dadosParaGravar = JSON.stringify(maquinasIndustriais, null, 2);
const nomeDoArquivo = "maquinas.json";
fs.writeFileSync(nomeDoArquivo, dadosParaGravar);
console.log(`\nGravacao concluida com sucesso.`)
console.log(`verifique o arquivo '${nomeDoArquivo} gerado`);