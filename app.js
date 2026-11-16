/*
Atualizado para acompanhar as alterações da interface HTML.

Mudanças:
- Questionário dividido em 5 etapas.
- Exibição de 3 perguntas por etapa.
- Adição de barra de progresso.
- Inclusão dos botões Voltar e Próximo.
- Ajuste do fluxo para exibir uma categoria por vez.
*/
const etapas = [
    {
        categoria: "Alimentação",
        perguntas: [
            "Sua alimentação diária inclui pelo menos 5 porções de frutas e hortaliças?",
            "Você evita ingerir alimentos gordurosos (carnes gordas, frituras) e doces?",
            "Você faz 4 a 5 refeições variadas ao dia, incluindo um bom café da manhã?"
        ]
    },
    {
        categoria: "Atividade Física",
        perguntas: [
            "Seu lazer inclui a prática de atividades físicas (exercícios, esportes ou dança)?",
            "Ao menos duas vezes por semana você realiza exercícios que envolvam força e alongamento muscular?",
            "Você caminha ou pedala como meio de deslocamento e utiliza escadas ao invés do elevador?"
        ]
    },
    {
        categoria: "Comportamento Preventivo",
        perguntas: [
            "Você conhece sua pressão arterial, seus níveis de colesterol e procura controlá-los?",
            "Você se abstém de fumar e ingere álcool com moderação (ou não bebe)?",
            "Você respeita as normas de trânsito e utiliza sempre o cinto de segurança?"
        ]
    },
    {
        categoria: "Relacionamentos",
        perguntas: [
            "Você procura cultivar amigos e está satisfeito com seus relacionamentos?",
            "Seu lazer inclui encontros com amigos ou participação em atividades sociais?",
            "Você procura ser ativo em sua comunidade?"
        ]
    },
    {
        categoria: "Controle do Estresse",
        perguntas: [
            "Você reserva tempo todos os dias para relaxar?",
            "Você mantém uma discussão sem alterar-se, mesmo quando contrariado?",
            "Você equilibra o tempo dedicado ao trabalho com o tempo dedicado ao lazer?"
        ]
    }
];

let etapaAtual = 0;
const respostas = {};

const telaInicial = document.getElementById("telaInicial");
const telaQuestionario = document.getElementById("telaQuestionario");
const resultado = document.getElementById("resultado");

const tituloCategoria = document.getElementById("tituloCategoria");
const contadorEtapa = document.getElementById("contadorEtapa");
const perguntasEtapa = document.getElementById("perguntasEtapa");
const barra = document.getElementById("barra");

document
    .getElementById("iniciarBtn")
    .addEventListener("click", iniciarQuestionario);

document
    .getElementById("proximoBtn")
    .addEventListener("click", avancarEtapa);

document
    .getElementById("voltarBtn")
    .addEventListener("click", voltarEtapa);

function iniciarQuestionario() {

    const idUsuario =
        document.getElementById("idUsuario").value;

    if (!idUsuario) {
        alert("Informe o ID do usuário.");
        return;
    }

    telaInicial.style.display = "none";
    telaQuestionario.style.display = "block";

    renderizarEtapa();
}

function renderizarEtapa() {

    const etapa = etapas[etapaAtual];

    tituloCategoria.textContent = etapa.categoria;

    contadorEtapa.textContent =
        `Etapa ${etapaAtual + 1} de ${etapas.length}`;

    barra.style.width =
        `${((etapaAtual + 1) / etapas.length) * 100}%`;

    perguntasEtapa.innerHTML = "";

    etapa.perguntas.forEach((pergunta, indice) => {

        const numeroGlobal =
            (etapaAtual * 3) + indice + 1;

        const respostaSalva =
            respostas[numeroGlobal];

        const div = document.createElement("div");

        div.className = "pergunta";

        div.innerHTML = `
            <h3>
                ${numeroGlobal}. ${pergunta}
            </h3>

            <div class="opcoes">

                <label>
                    <input
                        type="radio"
                        name="p${numeroGlobal}"
                        value="3"
                        ${respostaSalva == 3 ? "checked" : ""}>
                    Sempre
                </label>

                <label>
                    <input
                        type="radio"
                        name="p${numeroGlobal}"
                        value="2"
                        ${respostaSalva == 2 ? "checked" : ""}>
                    Quase sempre
                </label>

                <label>
                    <input
                        type="radio"
                        name="p${numeroGlobal}"
                        value="1"
                        ${respostaSalva == 1 ? "checked" : ""}>
                    Às vezes
                </label>

                <label>
                    <input
                        type="radio"
                        name="p${numeroGlobal}"
                        value="0"
                        ${respostaSalva == 0 ? "checked" : ""}>
                    Nunca
                </label>

            </div>
        `;

        perguntasEtapa.appendChild(div);
    });

    document.getElementById("voltarBtn").style.visibility =
        etapaAtual === 0
            ? "hidden"
            : "visible";

    const btnProximo =
        document.getElementById("proximoBtn");

    btnProximo.textContent =
        etapaAtual === etapas.length - 1
            ? "Gerar Feedback"
            : "Próximo →";
}

function salvarRespostasDaEtapa() {

    const etapa = etapas[etapaAtual];

    for (let i = 0; i < etapa.perguntas.length; i++) {

        const numeroGlobal =
            (etapaAtual * 3) + i + 1;

        const resposta = document.querySelector(
            `input[name="p${numeroGlobal}"]:checked`
        );

        if (!resposta) {

            alert(
                `Responda todas as perguntas desta etapa.`
            );

            return false;
        }

        respostas[numeroGlobal] =
            parseInt(resposta.value);
    }

    return true;
}

function avancarEtapa() {

    if (!salvarRespostasDaEtapa()) {
        return;
    }

    if (etapaAtual < etapas.length - 1) {

        etapaAtual++;

        renderizarEtapa();

    } else {

        enviarRespostas();
    }
}

function voltarEtapa() {

    if (etapaAtual > 0) {

        etapaAtual--;

        renderizarEtapa();
    }
}

async function enviarRespostas() {

    try {

        document.getElementById("proximoBtn").disabled = true;

        const retorno = await fetch(
            "http://127.0.0.1:5000/api/feedback",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    id_usuario: parseInt(
                        document.getElementById("idUsuario").value
                    ),
                    respostas: respostas
                })
            }
        );

        if (!retorno.ok) {

            const erro = await retorno.text();

            throw new Error(erro);
        }

        const svg = await retorno.text();

        telaQuestionario.style.display = "none";

        resultado.style.display = "block";

        document
            .getElementById("graficoContainer")
            .innerHTML = svg;

    } catch (erro) {

        console.error(erro);

        alert(
            "Erro ao gerar feedback."
        );

        document.getElementById("proximoBtn").disabled = false;
    }
}